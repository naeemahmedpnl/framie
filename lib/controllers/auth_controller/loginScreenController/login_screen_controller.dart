import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user.model.dart';
import '../../../service/network_manager.dart';
import '../../../service/repository/auth_repository.dart';
import '../../../utils/loaders.dart';
import '../../../views/auth/otp/otp_screen.dart';

class LoginController extends GetxController {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;

  Future<void> login() async {
    // Check for internet connection
    final isConnected = await NetworkManager().isConnected();
    if (!isConnected) {
      BeautyLoaders.warningSnackBar(
        title: 'Internet Issue',
        message: 'Please connect to the internet.',
      );
      return;
    }

    // Validate input fields
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      BeautyLoaders.warningSnackBar(
        title: 'Error',
        message: "All fields are required.",
      );
      return;
    }

    isLoading.value = true;

    try {
      // Initialize repository and send register request
      final authRepo = AuthRepository();
      final response = await authRepo.signIn(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );

      log('Response: $response');

      if (response['success'] == true) {
        final userData = response['data'];
        UserModel user = UserModel.fromJson(userData);

        // await UserSession().saveUser(user);
        // UserSession.userModel.value = user;

        BeautyLoaders.successSnackBar(
          title: 'Success',
          message: 'Login Successful!',
        );

        if (user.isVerified == false) {
          Get.to(
            () => OTPVerificationScreen(
              otp: userData["OTP"],
              userId: user.id,
              email: user.email.toString(),
            ),
          );
        }
        // Get.offAll(() => NavigationMenu());

        // Get.offAll(() => CheckIfUserExistsView());
        // await checkScreen();
      } else {
        isLoading.value = false;
        BeautyLoaders.errorSnackBar(
          title: 'Error',
          message: response['msg'] ?? 'An unknown error occurred.',
        );
      }
    } catch (e) {
      log('Error: $e');
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
