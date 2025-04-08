import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../service/user_session/user_session.dart';

class AddServiceController extends GetxController {
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  var selectedStartTime = "09".obs;
  var selectedEndTime = "10".obs;
  var selectedStartDay = "MON".obs;
  var selectedEndDay = "FRI".obs;
  var selectedCategory = "".obs;
  var selectedImage = Rx<File?>(null);

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

  RxBool isLoading = false.obs;

  // Future<void> pickImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     selectedImage.value = File(image.path);
  //   }
  // }

  void pickImage({ImageSource source = ImageSource.gallery}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  List<String> categories = [
    "Hair Services",
    "Skin Services",
    "Nail Services",
    "Others"
  ];

  // void updateService() {
  //   Get.to(() => ServiceBookingDetailsScreen());
  // }

  Future<void> updateService() async {
    log("🔍 API Request Start...");
    isLoading.value = true;

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(
        "https://appsdemo.pro/Framie/api/admin/addService",
      ),
    );

    log("➡️ API URL: ${request.url}");
    String? token = await UserSession().getUserToken();

    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'multipart/form-data';
    request.fields['adminId'] = UserSession.userModel.value.id;
    request.fields['Title'] = selectedCategory.value;
    request.fields['text'] = descriptionController.text;

    log("📌 Request Fields:");
    log("adminId: ${request.fields['adminId']}");
    log("Title: ${request.fields['Title']}");
    log("Description: ${request.fields['text']}");

    if (selectedImage.value != null) {
      log("🖼️ Image Selected: ${selectedImage.value!.path}");

      request.files.add(
        await http.MultipartFile.fromPath(
          'ServiceImage',
          selectedImage.value!.path,
        ),
      );
    } else {
      log("⚠️ No Image Selected");
    }

    try {
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      log("📌 Status Code: ${response.statusCode}");
      log("📄 Response Body: $responseData");
      isLoading.value = false;

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Service Added Successfully");
      } else {
        Get.snackbar("Error", "Failed to add service");
      }
    } catch (e) {
      isLoading.value = false;

      log("❌ API Error: $e");
      Get.snackbar("Error", "Something went wrong");
    }
    isLoading.value = false;

    log("✅ API Request End...");
  }

  @override
  void onClose() {
    serviceNameController.dispose();
    categoryController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
