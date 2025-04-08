import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user.model.dart';
import '../../../service/network_manager.dart';
import '../../../service/repository/auth_repository.dart';
import '../../../service/user_session/user_session.dart';
import '../../../utils/loaders.dart';
import '../../../views/nav_menu/navigation_menu.dart';

class OTPVerificationController extends GetxController {
  List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());

  var isLoading = false.obs;

  void verifyOTP(String email) async {
    String otpCode = otpControllers.map((controller) => controller.text).join();

    if (otpCode.length < 6) {
      Get.snackbar(
        "Error",
        "Please enter all 6 digits",
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isLoading.value = true;

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
    if (otpCode.isEmpty) {
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
      final response = await authRepo.verifyOTP(
        email: email,
        otp: otpCode,
      );

      log('Response: $response');

      if (response['success'] == true) {
        final userData = response['data'];
        log('This is data $userData');
        UserModel user = UserModel.empty();
        user.name =
            '${response['data']['firstName']} ${response['data']['lastName']}';
        user.phNumber = response['data']['phNumber'];
        user.city = response['data']['city'];
        user.email = response['data']['email'];
        user.id = response['data']['_id'];
        user.isVerified = response['data']['isVerified'];
        log(user.toString());

        await UserSession().saveUser(user);
        UserSession.userModel.value = user;

        BeautyLoaders.successSnackBar(
          title: 'Success',
          message: 'User Verified!',
        );
        Get.to(() => NavigationMenu());

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

  void resendOTP({required String userId}) async {
    Get.snackbar("OTP Sent", "A new OTP has been sent to your number",
        snackPosition: SnackPosition.BOTTOM);
    final authRepo = AuthRepository();
    await authRepo.resendOTP(userId: userId);
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
