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
      final authRepo = AdminAuthRepository();

      final response = await authRepo.signIn(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );

      log('Login Response: $response');

      // ✅ FIX: Check for status code and success message
      if (response['success'] == true) {
        log('✅ Navigating to AccountSettingsView...');

        final userData = response['data'];
        log('This is user Data $userData ');
        UserModel user = UserModel.fromMap(userData);

        log('Admin Model: $user ');

        await UserSession().saveBussinessProfileValue(
          userData["businessProfile"],
        );

        await UserSession().saveUser(user);
        await UserSession().saveUserType(true);
        UserSession.userModel.value = user;

        BeautyLoaders.successSnackBar(
          title: 'Success',
          message: response['msg'] ?? 'Login Successful!',
        );

        // ✅ Ensure navigation executes
        Future.delayed(Duration(milliseconds: 300), () {
          if (userData["businessProfile"] == false) {
            Get.offAll(() => BusinessProfileCraeteView());
          } else {
            Get.offAll(() => AdminNavigationMenu());
          }
        });
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
