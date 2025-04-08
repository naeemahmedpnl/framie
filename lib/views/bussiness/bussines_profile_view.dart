import 'package:beauty/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/bussiness/bussiness_details_view_controller.dart';
import '../../service/service_constants/configs.dart';
import 'edit_bussiness_profile_view.dart';

class BussinessProfileView extends StatelessWidget {
  const BussinessProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BussinessDetailsViewController());
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
          'Business Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final business = controller.bussinessData;
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile header
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        '$kBaseUrl/${business.value!.profileImage.toString()}',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      business.value!.businessName.toString(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '@${business.value!.businessName}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          '${business.value!.address}, ${business.value!.city}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Divider(height: 32),

              // Services Section
              _SectionTitle(title: 'Services'),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: (business.value!.availableServices)
                    .map((service) => Chip(
                          label: Text(service),
                          backgroundColor: Colors.blue.withValues(alpha: 0.1),
                          labelStyle: TextStyle(color: Colors.blue),
                        ))
                    .toList(),
              ),

              SizedBox(height: 24),

              // Working Hours Section
              _SectionTitle(title: 'Working Hours'),
              SizedBox(height: 8),
              Column(
                children: (business.value!.workingDays)
                    .map((day) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                day.day,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              day.isActive
                                  ? Text(
                                      '${day.openingTime} - ${day.closeingTime}')
                                  : Text('Closed',
                                      style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ))
                    .toList(),
              ),

              SizedBox(height: 32),

              // Contact Button
              CustomButton(
                text: 'Edit Details',
                onPressed: () {
                  Get.to(
                    () => EditBusinessProfileCraeteView(
                      bussinessProfile: controller.bussinessData.value!,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

// Helper widget for section titles
class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
