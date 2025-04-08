import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HairServiceModel {
  String title;
  String description;
  double price;
  File? image;

  HairServiceModel({
    this.title = '',
    this.description = '',
    this.price = 0.0,
    this.image,
  });
}

class MultiServiceProfileCreateViewController extends GetxController {
  final services = <HairServiceModel>[HairServiceModel()].obs;

  final introductionText = ''.obs;
  final headerImage = Rx<File?>(null);

  void addService() {
    services.add(HairServiceModel());
  }

  Future<void> pickImage(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (index == -1) {
        headerImage.value = File(pickedFile.path);
      } else {
        services[index].image = File(pickedFile.path);
        services.refresh();
      }
    }
  }
}
