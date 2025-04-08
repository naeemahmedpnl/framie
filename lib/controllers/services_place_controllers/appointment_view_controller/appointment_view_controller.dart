import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController {
  final RxDouble radiusValue = 1.0.obs;
  final RxBool useCurrentLocation = false.obs;
  final RxBool enableHomeServices = true.obs;
  final TextEditingController locationController = TextEditingController();

  @override
  void onClose() {
    locationController.dispose();
    super.onClose();
  }

  void updateRadius(double value) {
    radiusValue.value = value;
  }

  void toggleCurrentLocation(bool value) {
    useCurrentLocation.value = value;
    if (value) {
      // Here you would normally fetch current location
      locationController.text = "Current location";
    } else {
      locationController.text = "";
    }
  }

  void toggleHomeServices(bool value) {
    enableHomeServices.value = value;
  }
}
