import 'dart:developer';
import 'dart:io';

import 'package:beauty/service/user_session/user_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/admin_models/admin.sub.service.model.dart';
import '../../service/repository/sub_repository.dart';

class SubServiceSalonViewController extends GetxController {
  final introductionText = ''.obs;
  final headerImage = Rx<File?>(null);
  final businessLogo = Rxn<File>();

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      businessLogo.value = File(image.path);
    }
  }

  final priceController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final isLoading = false.obs;
  final SubSalonRepository _authRepository = SubSalonRepository();

  // Method to submit the business profile
  Future<void> createSubService(String serviceId) async {
    if (priceController.text.isEmpty ||
        titleController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all required fields');
      return;
    }

    isLoading.value = true;

    try {
      String adminId = UserSession.userModel.value.id;

      // Create business profile object
      final profile = AddSubService(
        adminId: adminId,
        price: priceController.text,
        serviceId: serviceId,
        text: descriptionController.text,
        title: titleController.text,
      );

      // Call the API
      final result = await _authRepository.createSubSalon(
        subService: profile,
        businessImage: businessLogo.value!,
      );

      isLoading.value = false;

      // Handle the response
      if (result['success']) {
        Get.snackbar('Success', 'Subservice created successfully');
        // Navigate to next screen or dashboard
        // Get.offAllNamed('/dashboard');
      } else {
        Get.snackbar('Error', result['msg'] ?? 'Failed to create Subservice');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'An unexpected error occurred');
      log('Error creating business profile: $e');
    }
  }
}
