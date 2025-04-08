import 'package:beauty/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/bussiness/add_sub_salon_controller.dart';
import '../../../models/salon.response.model.dart';

class AddSubServiceView extends StatefulWidget {
  final ServiceSalon salon;
  const AddSubServiceView({super.key, required this.salon});

  @override
  State<AddSubServiceView> createState() => _AddSubServiceViewState();
}

class _AddSubServiceViewState extends State<AddSubServiceView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubServiceSalonViewController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Add Sub Service',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.salon.title.toString(),
                style: TextStyle(
                  color: Color(0xFF6A1B9A),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Please provide details of the ${widget.salon.title.toString()} you are offering.',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),

              // Header Image Upload
              Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "Https://appsdemo.pro/Framie/${widget.salon.bannerImage}",
                      fit: BoxFit.cover,
                    ),
                  )),
              SizedBox(height: 20),

              // Service List
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Service',
                    style: TextStyle(
                      color: Color(0xFF6A1B9A),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),

                  // Service Image
                  Row(
                    children: [
                      Obx(() => GestureDetector(
                            onTap: controller.pickImage,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: controller.businessLogo.value != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        controller.businessLogo.value!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_a_photo_outlined,
                                          color: Colors.grey[700],
                                          size: 30,
                                        ),
                                      ],
                                    ),
                            ),
                          )),
                      SizedBox(width: 10),
                      Text(
                        'Upload service image',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Service Title
                  TextField(
                    controller: controller.titleController,
                    decoration: InputDecoration(
                      hintText: 'Service Title',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      border: UnderlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Service Description
                  TextField(
                    controller: controller.descriptionController,
                    maxLines: 4,
                    maxLength: 100,
                    decoration: InputDecoration(
                      hintText: 'Service description text (100 words)',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      border: UnderlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),

                  // Service Price
                  Row(
                    children: [
                      Text(
                        'Service Price',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        '\$',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: TextField(
                          controller: controller.priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20),

              CustomButton(
                text: 'Continue',
                isLoading: controller.isLoading.value,
                onPressed: () async {
                  await controller.createSubService(widget.salon.id.toString());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
