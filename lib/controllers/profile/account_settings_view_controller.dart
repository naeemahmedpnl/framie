import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user.model.dart';
import '../../service/network_manager.dart';
import '../../service/repository/auth_repository.dart';
import '../../service/user_session/user_session.dart';
import '../../utils/loaders.dart';

class AccountSettingsController extends GetxController {
  final selectedCity = 'London & South East'.obs;

  final List<String> cities = [
    'London & South East',
    'Manchester',
    'Birmingham',
    'Edinburgh',
    'Cardiff',
    'Belfast',
    'Liverpool'
  ];

  void updateCity(String? city) {
    if (city != null) {
      selectedCity.value = city;
    }
  }

  RxBool isLoading = false.obs;

  Future<void> saveChanges({
    required String name,
    required String city,
    required String phone,
  }) async {
    // Check for internet connection
    final isConnected = await NetworkManager().isConnected();
    if (!isConnected) {
      BeautyLoaders.warningSnackBar(
        title: 'Internet Issue',
        message: 'Please connect to the internet.',
      );
      return;
    }

    isLoading.value = true;

    try {
      // Initialize repository and send register request
      final authRepo = AuthRepository();
      List<String> nameParts = name.trim().split(' ');
      String firstName = nameParts.isNotEmpty ? nameParts.first : '';
      String lastName =
          nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
      final response = await authRepo.updateUserAccount(
        city: city,
        firstName: firstName,
        lastName: lastName,
        phNumber: phone,
      );

      log('Response: $response');

      if (response['success'] == true) {
        final userData = response['data'];

        log(response['data'].toString());
        UserModel user = UserModel.fromJson(userData);

        user.name = '$firstName $lastName';

        await UserSession().saveUser(user);

        BeautyLoaders.successSnackBar(
          title: 'Success',
          message: 'Profile updated successfully.',
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

  void showDeleteConfirmation() {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
