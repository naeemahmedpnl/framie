import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceInViewController extends GetxController {
  final selectedAddressType = 'Home'.obs;
  final streetAndFlatController = TextEditingController();
  final streetController = TextEditingController();
  final postcodeController = TextEditingController();
  final cityController = TextEditingController();

  void setAddressType(String type) {
    selectedAddressType.value = type;
  }

  void saveAddress() {
    // Logic to save address
    Get.snackbar(
      'Success',
      'Address saved successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.purple.shade100,
      colorText: Colors.purple.shade900,
    );
  }
}
