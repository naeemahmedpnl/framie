import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotInServiceViewController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString locationStatus = 'Still Working On Your Location!'.obs;
  final RxString expansionMessage =
      'We\'re working on expanding to more locations, stay tuned for updates!'
          .obs;

  void sendQueryToSupport() {
    isLoading.value = true;
    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
      Get.snackbar(
        'Query Sent',
        'Our customer support team will contact you soon',
        backgroundColor: Colors.purple.shade100,
        colorText: Colors.purple.shade900,
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }
}
