import 'dart:developer';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../models/user.model.dart';
import '../../../service/network_manager.dart';
import '../../../service/repository/auth_repository.dart';
import '../../../service/user_session/user_session.dart';
import '../../../utils/loaders.dart';
import '../../../views/nav_menu/navigation_menu.dart';

class GoogleSignInController extends GetxController {
  var isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final AuthRepository _authRepository = AuthRepository();

  Future<void> handleGoogleSignIn() async {
    log('Starting Google Sign-In process');
    isLoading.value = true;

    try {
      // Check for internet connection
      final isConnected = await NetworkManager().isConnected();
      if (!isConnected) {
        BeautyLoaders.warningSnackBar(
          title: 'Internet Issue',
          message: 'Please connect to the internet.',
        );
        isLoading.value = false;
        return;
      }

      // Get Google Sign-In account
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        isLoading.value = false;
        log('Google Sign-In was canceled');
        return;
      }

      // Get Google auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with Google credentials
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        log('Firebase sign-in successful! User ID: ${firebaseUser.uid}');
        log('User email: ${firebaseUser.email}');
        log('User display name: ${firebaseUser.displayName}');

        // Split name into first and last name
        String displayName = firebaseUser.displayName ?? 'User';
        List<String> nameParts = displayName.split(' ');
        String firstName = nameParts.first;
        String lastName =
            nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

        // Create request body for your backend API
        Map<String, dynamic> userData = {
          'email': firebaseUser.email,
          'firstName': firstName,
          'lastName': lastName
        };

        // Send data to your backend API
        final response = await _authRepository.signUpWithGoogle(userData);

        if (response['success'] == true) {
          // Handle successful sign in with backend
          final apiUserData = response['data'];
          log('API user data received: $apiUserData');

          // Create user model from response
          UserModel user = UserModel.empty();
          user.name =
              '${apiUserData['firstName'] ?? ''} ${apiUserData['lastName'] ?? ''}'
                  .trim();
          user.email = apiUserData['email'] ?? '';
          user.id = apiUserData['_id'] ?? '';
          user.isVerified = apiUserData['isVerified'] ?? true;

          log('User model created: $user');

          // Save user session
          try {
            log('Saving user session...');
            await UserSession().saveUser(user);
            log('User session saved successfully');
            UserSession.userModel.value = user;

            BeautyLoaders.successSnackBar(
              title: 'Success',
              message: 'Google Sign-In Successful!',
            );

            // Add a delay before navigation
            log('Preparing to navigate...');
            await Future.delayed(Duration(milliseconds: 500));

            log('Navigating to NavigationMenu');
            Get.offAll(() => NavigationMenu());
            log('Navigation command issued');
          } catch (e) {
            log('Error during session saving or navigation: $e');
            // Handle error
          }
        } else {
          BeautyLoaders.errorSnackBar(
            title: 'Error',
            message: response['msg'] ??
                'Failed to complete sign-in with our servers.',
          );
        }
      }
    } catch (e) {
      log('Error during Google Sign-In: $e');
      log('Stack trace: ${StackTrace.current}');

      BeautyLoaders.errorSnackBar(
        title: 'Error',
        message: 'Sign-in failed. Please try again later.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> isSignedIn() async {
    // Check if a user is signed in with Firebase
    return _auth.currentUser != null || await _googleSignIn.isSignedIn();
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<void> signInWithGoogle() async {
    try {
      await handleGoogleSignIn();
    } catch (e) {
      log('Error during Google Sign-In: $e');
    }
  }

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
