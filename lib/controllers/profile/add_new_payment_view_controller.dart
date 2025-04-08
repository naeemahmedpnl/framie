import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethodController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final cardNumberController = TextEditingController();
  final nameController = TextEditingController();
  final cvvController = TextEditingController();
  final postcodeController = TextEditingController();

  final selectedTab = 0.obs;
  final selectedMonth = Rxn<String>();
  final selectedYear = Rxn<String>();

  // Dropdown items
  final List<String> months = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ];

  final List<String> years = [
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030',
    '2031',
    '2032'
  ];

  void changeTab(int tab) {
    selectedTab.value = tab;
  }

  void scanCard() {
    Get.snackbar(
      'Scan Card',
      'Card scanning functionality would be implemented here',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your card number';
    }
    if (value.length < 16) {
      return 'Please enter a valid card number';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter CVV';
    }
    if (value.length < 3) {
      return 'CVV must be at least 3 digits';
    }
    return null;
  }

  String? validatePostcode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your postcode';
    }
    return null;
  }

  void addCard() {
    if (formKey.currentState!.validate() &&
        selectedMonth.value != null &&
        selectedYear.value != null) {
      // Process the card data
      Get.snackbar(
        'Success',
        'Card added successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        'Please fill all the required fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    cardNumberController.dispose();
    nameController.dispose();
    cvvController.dispose();
    postcodeController.dispose();
    super.onClose();
  }
}
