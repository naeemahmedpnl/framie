import 'dart:developer';
import 'dart:io';

import 'package:beauty/service/user_session/user_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/admin_models/create_employee_model.dart';
import '../../../service/repository/all_employees_repository.dart';

class CreateEmployeeController extends GetxController {
  final businessName = ''.obs;
  final selectedCity = Rxn<String>();
  final address = ''.obs;
  final businessLogo = Rxn<File>();
  final userName = ''.obs;

  final selectedIds = <String>[].obs;

  final services = <String>[].obs;
  final availableServices = ['Hair', 'Nails', 'Skin', 'Body'];

  final startHour = 9.obs;
  final endHour = 10.obs;
  final timeFormat = 'AM'.obs;

  final startDay = 'MON'.obs;
  final endDay = 'FRI'.obs;
  final weekdays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

  final isLoading = false.obs;

  final AllEmployeesRepository _authRepository = AllEmployeesRepository();

  void toggleServiceId(String serviceId) {
    if (selectedIds.contains(serviceId)) {
      selectedIds.remove(serviceId);
    } else {
      selectedIds.add(serviceId);
    }
    update();
  }

  void toggleService(String service) {
    if (services.contains(service)) {
      services.remove(service);
    } else {
      services.add(service);
    }
  }

  /// **Function to Pick Image**
  void pickImage({ImageSource source = ImageSource.gallery}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      businessLogo.value = File(image.path);
    }
  }

  /// **Show Image Picker Menu**
  void showImageSourceMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(source: ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(source: ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  bool isFormValid() {
    return businessName.value.isNotEmpty &&
        selectedIds.isNotEmpty &&
        userName.isNotEmpty &&
        businessLogo.value != null;
  }

  List<WorkingDay> _getWorkingDays() {
    int startIndex = weekdays.indexOf(startDay.value);
    int endIndex = weekdays.indexOf(endDay.value);

    List<WorkingDay> workingDays = [];

    if (startIndex > endIndex) {
      for (int i = startIndex; i < weekdays.length; i++) {
        workingDays.add(_createWorkingDay(weekdays[i]));
      }
      for (int i = 0; i <= endIndex; i++) {
        workingDays.add(_createWorkingDay(weekdays[i]));
      }
    } else {
      for (int i = startIndex; i <= endIndex; i++) {
        workingDays.add(_createWorkingDay(weekdays[i]));
      }
    }

    return workingDays;
  }

  WorkingDay _createWorkingDay(String dayCode) {
    Map<String, String> dayNames = {
      'MON': 'Monday',
      'TUE': 'Tuesday',
      'WED': 'Wednesday',
      'THU': 'Thursday',
      'FRI': 'Friday',
      'SAT': 'Saturday',
      'SUN': 'Sunday',
    };

    String openingTime = '${startHour.value}:00';
    String closingTime = '${endHour.value}:00';

    if (timeFormat.value == 'PM' && startHour.value < 12) {
      openingTime = '${startHour.value + 12}:00';
    }
    if (timeFormat.value == 'PM' && endHour.value < 12) {
      closingTime = '${endHour.value + 12}:00';
    }

    return WorkingDay(
      day: dayNames[dayCode] ?? dayCode,
      isActive: true,
      startTime: openingTime,
      endTime: closingTime,
    );
  }

  Future<void> submitBusinessProfile() async {
    if (!isFormValid()) {
      Get.snackbar('Error', 'Please fill in all required fields');
      return;
    }

    isLoading.value = true;

    try {
      String adminId = UserSession.userModel.value.id;

      final profile = CreateAllEmployees(
        employeeName: businessName.value,
        about: userName.value,
        createdBy: adminId,
        availableServices: selectedIds.toList(),
        workingDays: _getWorkingDays(),
      );

      // Call the API
      final result = await _authRepository.addEmployeeProfile(
        profile: profile,
        businessImage: businessLogo.value!,
      );

      isLoading.value = false;

      // Handle the response
      if (result['success']) {
        Navigator.of(Get.context!).pop();
        Get.snackbar(
          'Success',
          'Employee profile created successfully',
        );
      } else {
        Get.snackbar(
          'Error',
          result['msg'] ?? 'Failed to create employee profile',
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'An unexpected error occurred');
      log('Error creating employee profile: $e');
    }
  }
}
