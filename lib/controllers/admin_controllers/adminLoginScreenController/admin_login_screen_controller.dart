

import 'dart:developer';
import 'package:beauty/service/user_session/user_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/service/network_manager.dart';
import '/service/repository/admin_auth_repository/admin_auth_repository.dart';
import '/utils/loaders.dart';
import '/views/nav_admin_view/nav_admin_view.dart';
import '../../../models/user.model.dart';
import '../../../views/bussiness/bussiness_profile_create_view.dart';

class AdminLoginController extends GetxController {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;
 
  final AdminAuthRepository authRepo = AdminAuthRepository();
  
  Future<void> adminLogin() async {
    try {
      // Check internet connection
      if (!await NetworkManager().isConnected()) {
        BeautyLoaders.warningSnackBar(
          title: 'Internet Issue',
          message: 'Please connect to the internet.',
        );
        return;
      }
     
      // Validate input fields
      if (usernameController.text.trim().isEmpty ||
          passwordController.text.trim().isEmpty) {
        BeautyLoaders.warningSnackBar(
          title: 'Error',
          message: "All fields are required.",
        );
        return;
      }
     
      isLoading.value = true;
     
      final response = await authRepo.signIn(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );
     
      log('Login Response: $response');
     
      // Check for success flag
      if (response['success'] == true) {
        log('Login successful...');
        final userData = response['data'];
        log('Admin Data: $userData');
       
        // Validate that userData is not null and contains required fields
        if (userData != null && userData is Map<String, dynamic>) {
          // Create user model from response data
          UserModel admin = UserModel.fromMap(userData);
          log('Admin Model: $admin');
         
          // Get the token from response
          String token = response['accessToken'] ?? '';
         
          // Check if we have valid admin data
          if (admin.id.isNotEmpty) {
            // Save admin data to local storage
            bool? businessProfile = userData["businessProfile"];
            await UserSession().saveBussinessProfileValue(businessProfile ?? false);
            await UserSession().saveUser(admin);
            await UserSession().saveUserType(true);
            UserSession.userModel.value = admin;
           
            // Sync admin data to Firebase
            bool syncSuccess = await authRepo.syncAdminToFirebase(admin, token);
            log('Firebase sync result: ${syncSuccess ? "Success" : "Failed"}');
           
            BeautyLoaders.successSnackBar(
              title: 'Success',
              message: response['msg'] ?? 'Login Successful!',
            );
           
            // Navigate based on business profile status
            Future.delayed(Duration(milliseconds: 300), () {
              if (businessProfile == false) {
                Get.offAll(() => BusinessProfileCraeteView());
              } else {
                Get.offAll(() => AdminNavigationMenu());
              }
            });
            return;
          }
        }
        
        // If we get here, something went wrong with the data
        BeautyLoaders.errorSnackBar(
          title: 'Error',
          message: 'Invalid user data received. Please try again.',
        );
      } else {
        BeautyLoaders.errorSnackBar(
          title: 'Error',
          message: response['msg'] ?? 'Login failed. Please try again.',
        );
      }
    } catch (e) {
      log('Login Error: $e');
      BeautyLoaders.errorSnackBar(
        title: 'Error',
        message: 'An error occurred. Please try again later.',
      );
    } finally {
      isLoading.value = false;
    }
  }
 
  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}