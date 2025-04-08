import 'package:beauty/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/add_service/add_service_controller.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final controller = Get.put(AddServiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Add Service", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add your details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Please confirm your details",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  Obx(() {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: controller.selectedImage.value != null
                          ? Image.file(
                              controller.selectedImage.value!,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                    );
                  }),
                  Positioned(
                    bottom: -10,
                    child: FloatingActionButton(
                      onPressed: () {
                        controller.showImageSourceMenu(context);
                      },
                      mini: true,
                      backgroundColor: Colors.purple,
                      child: Icon(Icons.camera_alt, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildCategoryDropdown(controller),
              _buildTextField(
                controller.descriptionController,
                "Description",
                maxLines: 4,
              ),
              SizedBox(height: 20),
              Obx(
                () => CustomButton(
                  text: "Add",
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.updateService();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown(AddServiceController controller) {
    List<String> categories = [
      "Hair Services",
      "Skin Services",
      "Nail Services",
      "Others"
    ];

    if (controller.categoryController.text.isNotEmpty &&
        categories.contains(controller.categoryController.text)) {
      controller.selectedCategory.value = controller.categoryController.text;
    } else if (controller.selectedCategory.value.isEmpty) {
      controller.selectedCategory.value = categories.first;
    }

    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: DropdownButtonFormField(
          value: controller.selectedCategory.value,
          decoration: InputDecoration(
            hintText: "Select Category",
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.purple, width: 2),
            ),
          ),
          items: categories.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(category),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              controller.selectedCategory.value = value;
              controller.categoryController.text = value;
            }
          },
        ),
      );
    });
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {int maxLines = 1}) {
    bool isDescriptionField = maxLines > 1;

    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          border: isDescriptionField
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey))
              : UnderlineInputBorder(),
          enabledBorder: isDescriptionField
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey))
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: isDescriptionField
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.purple, width: 2))
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple, width: 2)),
        ),
      ),
    );
  }
}
