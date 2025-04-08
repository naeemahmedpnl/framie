import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/bussiness_profile_model.dart';
import '../../service/repository/bussiness_repositry.dart';
import '../../service/user_session/user_session.dart';
import '../../views/nav_admin_view/nav_admin_view.dart';

class BusinessProfileCreateViewController extends GetxController {
  final businessName = ''.obs;
  final selectedCity = Rxn<String>();
  final address = ''.obs;
  final businessLogo = Rxn<File>();
  final userName = ''.obs; // Added for the API request

  final services = <String>[].obs;
  final availableServices = ['Hair', 'Nails', 'Skin', 'Body'];
  final selectedServices = <String>[].obs;

  final startHour = 9.obs;
  final endHour = 10.obs;
  final timeFormat = 'AM'.obs;

  final startDay = 'MON'.obs;
  final endDay = 'FRI'.obs;
  final weekdays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

  // Add loading state
  final isLoading = false.obs;

  // Add repository
  final BussinessRepository _authRepository = BussinessRepository();

  void toggleService(String service) {
    if (services.contains(service)) {
      services.remove(service);
      if (service == 'Hair') {
        selectedServices.remove('Hair Services');
      }
      if (service == 'Nails') {
        selectedServices.remove('Nail Services');
      }
      if (service == 'Skin') {
        selectedServices.remove('Skin Services');
      }
      if (service == 'Body') {
        selectedServices.remove('Others Services');
      }
    } else {
      services.add(service);
      if (service == 'Hair') {
        selectedServices.add('Hair Services');
      }
      if (service == 'Nails') {
        selectedServices.add('Nail Services');
      }
      if (service == 'Skin') {
        selectedServices.add('Skin Services');
      }
      if (service == 'Body') {
        selectedServices.add('Others Services');
      }
    }
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      businessLogo.value = File(image.path);
    }
  }

  bool isFormValid() {
    return businessName.value.isNotEmpty &&
        selectedCity.value != null &&
        address.value.isNotEmpty &&
        services.isNotEmpty &&
        businessLogo.value != null;
  }

  // Convert working days to the format expected by the API
  List<WorkingDay> _getWorkingDays() {
    // Get indices of start and end days
    int startIndex = weekdays.indexOf(startDay.value);
    int endIndex = weekdays.indexOf(endDay.value);

    // Create working days list
    List<WorkingDay> workingDays = [];

    // If start day comes after end day in the week, we need to handle circular traversal
    if (startIndex > endIndex) {
      // From start day to the end of the week
      for (int i = startIndex; i < weekdays.length; i++) {
        workingDays.add(_createWorkingDay(weekdays[i]));
      }
      // From beginning of the week to end day
      for (int i = 0; i <= endIndex; i++) {
        workingDays.add(_createWorkingDay(weekdays[i]));
      }
    } else {
      // Normal traversal from start to end day
      for (int i = startIndex; i <= endIndex; i++) {
        workingDays.add(_createWorkingDay(weekdays[i]));
      }
    }

    return workingDays;
  }

  // Helper to create a working day object
  WorkingDay _createWorkingDay(String dayCode) {
    // Convert day code to full day name
    Map<String, String> dayNames = {
      'MON': 'Monday',
      'TUE': 'Tuesday',
      'WED': 'Wednesday',
      'THU': 'Thursday',
      'FRI': 'Friday',
      'SAT': 'Saturday',
      'SUN': 'Sunday',
    };

    // Format opening and closing times
    String openingTime = '${startHour.value}:00';
    String closingTime = '${endHour.value}:00';

    // Add AM/PM if needed
    if (timeFormat.value == 'PM' && startHour.value < 12) {
      openingTime = '${startHour.value + 12}:00';
    }
    if (timeFormat.value == 'PM' && endHour.value < 12) {
      closingTime = '${endHour.value + 12}:00';
    }

    return WorkingDay(
      day: dayNames[dayCode] ?? dayCode,
      isActive: true,
      openingTime: openingTime,
      closeingTime: closingTime,
    );
  }

  // Method to submit the business profile
  Future<void> submitBusinessProfile() async {
    if (!isFormValid()) {
      Get.snackbar('Error', 'Please fill in all required fields');
      return;
    }

    isLoading.value = true;

    try {
      String adminId = UserSession.userModel.value.id;

      // Create business profile object
      final profile = BusinessProfile(
        adminId: adminId,
        businessName: businessName.value,
        userName: userName.value.isEmpty
            ? businessName.value.replaceAll(' ', '').toLowerCase()
            : userName.value,
        city: selectedCity.value!,
        address: address.value,
        availableServices: selectedServices.toList(),
        workingDays: _getWorkingDays(),
      );

      // Call the API
      final result = await _authRepository.createBussinessProfile(
        profile: profile,
        businessImage: businessLogo.value!,
      );

      isLoading.value = false;

      // Handle the response
      if (result['success']) {
        Get.snackbar('Success', 'Business profile created successfully');
        // Navigate to next screen or dashboard
        // Get.offAllNamed('/dashboard');
        await UserSession().saveBussinessProfileValue(true);
        Get.offAll(() => AdminNavigationMenu());
      } else {
        Get.snackbar(
            'Error', result['msg'] ?? 'Failed to create business profile');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'An unexpected error occurred');
      log('Error creating business profile: $e');
    }
  }
}
