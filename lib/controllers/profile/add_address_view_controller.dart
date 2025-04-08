import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressController extends GetxController {
  final addressController = TextEditingController();
  final RxString address = ''.obs;

  void onAddressChanged(String value) {
    address.value = value;
  }

  void findMyLocation() {
    Get.snackbar(
      'Location Service',
      'Getting your current location...',
      backgroundColor: const Color(0xFF4A0072),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    addressController.dispose();
    super.onClose();
  }
}
