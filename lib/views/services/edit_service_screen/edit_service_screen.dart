import 'package:beauty/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/edit_service_controller/edit_service_controller.dart';
import '../../../models/salon.response.model.dart';

class EditServiceScreen extends StatefulWidget {
  final ServiceSalon salon;
  const EditServiceScreen({super.key, required this.salon});

  @override
  State<EditServiceScreen> createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
  final EditServiceController controller = Get.put(EditServiceController());

  @override
  void initState() {
    super.initState();
    controller.serviceNameController.text = widget.salon.title ?? '';
    controller.categoryController.text = widget.salon.title ?? '';
    controller.descriptionController.text = widget.salon.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Edit Service", style: TextStyle(color: Colors.black)),
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
                "Edit your details",
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "Https://appsdemo.pro/Framie/${widget.salon.bannerImage}",
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    child: FloatingActionButton(
                      onPressed: () {},
                      mini: true,
                      backgroundColor: Colors.purple,
                      child: Icon(Icons.arrow_upward, color: Colors.white),
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
              CustomButton(
                text: "Update",
                onPressed: () {
                  controller.updateService();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown(EditServiceController controller) {
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
