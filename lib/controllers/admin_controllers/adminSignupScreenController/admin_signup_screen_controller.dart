import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/service/repository/admin_auth_repository/admin_auth_repository.dart';
import '../../../models/user.model.dart';
import '../../../service/network_manager.dart';
import '../../../service/user_session/user_session.dart';
import '../../../utils/loaders.dart';
import '../../../views/bussiness/bussiness_profile_create_view.dart';

class AuthSignUpController extends GetxController {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var mobileController = TextEditingController();
  var cityController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  RxBool isLoading = false.obs;
  final businessLogo = Rxn<File>();
  var selectedCountryCode = '+1'.obs;

  void updateCountryCode(String code) {
    selectedCountryCode.value = code;
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

  /// **Register Admin with Image**
  Future<void> registerAdmin() async {
    // Check for internet connection
    final isConnected = await NetworkManager().isConnected();
    if (!isConnected) {
      BeautyLoaders.warningSnackBar(
        title: 'Internet Issue',
        message: 'Please connect to the internet.',
      );
      return;
    }

    // Validate input fields
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        mobileController.text.isEmpty ||
        cityController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      BeautyLoaders.warningSnackBar(
        title: 'Error',
        message: "All fields are required.",
      );
      return;
    }

    if (businessLogo.value == null) {
      BeautyLoaders.warningSnackBar(
        title: 'Error',
        message: "Please select a profile image.",
      );
      return;
    }

    isLoading.value = true;

    try {
      // Initialize repository and send register request
      final authRepo = AdminAuthRepository();
      final response = await authRepo.registerAdmin(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        city: cityController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        phNumber: mobileController.text.trim(),
        businessImage: businessLogo.value!,
      );

      log('Response: $response');

      if (response['success'] == true) {
        final userData = response['data'];
        UserModel user = UserModel.fromJson(userData);
        final accessToken = response['accessToken'];

        await UserSession().saveUser(user);
        UserSession.userModel.value = user;
        await UserSession().saveUserType(true);
        await UserSession().saveTokenUser(accessToken);

        BeautyLoaders.successSnackBar(
          title: 'Success',
          message: 'Registration Successful!',
        );

        Get.offAll(() => BusinessProfileCraeteView());
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


  

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
    cityController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
