import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user.model.dart';
import '../../../service/network_manager.dart';
import '../../../service/repository/auth_repository.dart';
import '../../../service/user_session/user_session.dart';
import '../../../utils/loaders.dart';

class SignUpController extends GetxController {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var mobileController = TextEditingController();
  var cityController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  RxBool isLoading = false.obs;

  void showCityPicker() {}
  var selectedCountryCode = '+1'.obs;

  void updateCountryCode(String code) {
    selectedCountryCode.value = code;
  }

  Future<void> registerUser() async {
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
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        mobileController.text.isEmpty ||
        cityController.text.isEmpty) {
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
      final response = await authRepo.registerUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        city: cityController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        phNumber: mobileController.text.trim(),
      );

      log('Response: $response');

      if (response['success'] == true) {
        final userData = response['data'];
        UserModel user = UserModel.fromJson(userData);

        await UserSession().saveUser(user);
        UserSession.userModel.value = user;

        BeautyLoaders.successSnackBar(
          title: 'Success',
          message: 'Registration Successful!',
        );

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

  // Future<void> checkScreen() async {
  //   await UserSession().getUser();
  //   final userModel = UserSession.userModel.value;

  //   if (userModel.name == null || userModel.name!.isEmpty) {
  //     Get.offAll(() => ProfileCreateResgisterView());
  //   } else if (userModel.email!.isEmpty) {
  //     Get.offAll(() => LoginView());
  //   } else {
  //     Get.offAll(() => NavHome());
  //   }
  // }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
    cityController.dispose();
    super.onClose();
  }
}
