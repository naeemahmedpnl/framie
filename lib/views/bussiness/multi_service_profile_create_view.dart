import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/bussiness/multi_service_profile_create_view_controller.dart';
import '../nav_admin_view/nav_admin_view.dart';

class CreateProfileServiceProfileCreateView extends StatelessWidget {
  const CreateProfileServiceProfileCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MultiServiceProfileCreateViewController());
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
          'Create Profile',
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
                'Hair Services',
                style: TextStyle(
                  color: Color(0xFF6A1B9A),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Please provide details of the hair services you are offering.',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),

              // Header Image Upload
              GestureDetector(
                onTap: () => controller.pickImage(-1),
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Obx(
                    () => controller.headerImage.value != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              controller.headerImage.value!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.arrow_upward,
                                  color: Color(0xFF6A1B9A),
                                  size: 20,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Upload header image for Hair services',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '800px × 400px',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Service Introduction
              TextField(
                onChanged: (value) => controller.introductionText.value = value,
                maxLines: 4,
                maxLength: 100,
                decoration: InputDecoration(
                  hintText: 'Service Introduction text (100 words)',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  border: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),

              // Service List
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.services.length,
                    itemBuilder: (context, index) {
                      return _buildServiceItem(index);
                    },
                  )),

              // Add Service Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: OutlinedButton.icon(
                  onPressed: controller.addService,
                  icon:
                      Icon(Icons.add_circle_outline, color: Color(0xFF6A1B9A)),
                  label: Text(
                    'Add Hair Service',
                    style: TextStyle(
                      color: Color(0xFF6A1B9A),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFF6A1B9A)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ),

              // Continue Button
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6A1B9A), Color(0xFFD81B60)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => AdminNavigationMenu());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceItem(int index) {
    final controller = Get.put(MultiServiceProfileCreateViewController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Text(
          'Service #${index + 1}',
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
            GestureDetector(
              onTap: () => controller.pickImage(index),
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Obx(
                  () => controller.services[index].image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            controller.services[index].image!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 24,
                            ),
                          ],
                        ),
                ),
              ),
            ),
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
          onChanged: (value) {
            controller.services[index].title = value;
          },
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
          onChanged: (value) {
            controller.services[index].description = value;
          },
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
                onChanged: (value) {
                  controller.services[index].price =
                      double.tryParse(value) ?? 0.0;
                },
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
    );
  }
}
