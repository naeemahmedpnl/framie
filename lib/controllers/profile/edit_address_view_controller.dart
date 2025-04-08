import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAddressController extends GetxController {
  final streetFlatController = TextEditingController();
  final streetController = TextEditingController();
  final postcodeController = TextEditingController();
  final cityController = TextEditingController();
  final parkingInfoController = TextEditingController();
  final additionalInfoController = TextEditingController();

  final addressType = RxString('Home');
  final hasStairs = RxString('Please Select');
  final hasCat = RxBool(true);
  final hasDog = RxBool(false);

  final List<String> stairsOptions = [
    'Please Select',
    'No Stairs',
    'Few Steps',
    '1 Flight',
    '2+ Flights',
    'Elevator Available'
  ];

  void changeAddressType(String type) {
    addressType.value = type;
  }

  void setHasStairs(String? value) {
    if (value != null) {
      hasStairs.value = value;
    }
  }

  void removeAddress() {
    Get.dialog(
      AlertDialog(
        title: const Text('Remove Address'),
        content: const Text('Are you sure you want to remove this address?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
              Get.snackbar(
                'Address Removed',
                'Your address has been removed successfully',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text(
              'Remove',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void saveChanges() {
    Get.back();
    Get.snackbar(
      'Address Updated',
      'Your address has been updated successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    streetFlatController.dispose();
    streetController.dispose();
    postcodeController.dispose();
    cityController.dispose();
    parkingInfoController.dispose();
    additionalInfoController.dispose();
    super.onClose();
  }
}
