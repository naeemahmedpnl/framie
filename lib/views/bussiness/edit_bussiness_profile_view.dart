import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/widgets/custom_button.dart';
import '../../controllers/bussiness/edit_bussones_profile_view_controller.dart';
import '../../models/bussiness_profile_admin.dart';
import '../../service/service_constants/configs.dart';

class EditBusinessProfileCraeteView extends StatefulWidget {
  final BusinessDataAdmin bussinessProfile;
  const EditBusinessProfileCraeteView({
    super.key,
    required this.bussinessProfile,
  });

  @override
  State<EditBusinessProfileCraeteView> createState() =>
      _EditBusinessProfileCraeteViewState();
}

class _EditBusinessProfileCraeteViewState
    extends State<EditBusinessProfileCraeteView> {
  final controller = Get.put(EditBusinessProfileCreateViewController());

  @override
  void initState() {
    super.initState();
    // Assign initial values to the controller
    controller.businessName.text = widget.bussinessProfile.businessName;
    controller.userName.text = widget.bussinessProfile.userName;
    controller.selectedCity.value = widget.bussinessProfile.city;
    controller.address.text = widget.bussinessProfile.address;
    controller.services.assignAll(widget.bussinessProfile.availableServices);
    log(widget.bussinessProfile.businessName);
    log(widget.bussinessProfile.userName);
    log(widget.bussinessProfile.city);
    log(widget.bussinessProfile.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Obx(() => Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Business Details Section
                      Text(
                        'Business Details',
                        style: TextStyle(
                          color: Color(0xFF6A1B9A),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Please confirm your details',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Business Logo
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Obx(() => GestureDetector(
                                onTap: controller.pickImage,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    // color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: controller.businessLogo.value != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            controller.businessLogo.value!,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(
                                            '$kBaseUrl/${widget.bussinessProfile.profileImage}',
                                          ),
                                        ),
                                ),
                              )),
                          SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              'Upload business logo',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Name Field
                      TextField(
                        controller: controller.businessName,
                        decoration: InputDecoration(
                          labelText: 'Business Name',
                          hintText: 'Enter your business name',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 15),

                      // Username Field (Added)
                      TextField(
                        controller: controller.userName,
                        decoration: InputDecoration(
                          labelText: 'Username (Optional)',
                          hintText:
                              'Enter a username or leave blank to auto-generate',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 15),

                      // City Dropdown
                      Obx(() => DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Choose City',
                              border: UnderlineInputBorder(),
                            ),
                            value: controller.selectedCity.value,
                            onChanged: (newValue) {
                              controller.selectedCity.value = newValue;
                            },
                            items: [
                              'New York',
                              'Los Angeles',
                              'Chicago',
                              'Miami',
                              'Dallas',
                              'Florida' // Added Florida to match your API example
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )),
                      SizedBox(height: 15),

                      // Address Field
                      TextField(
                        controller: controller.address,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          hintText: 'Enter your Address',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 30),

                      // Available Services Section
                      Text(
                        'Available Services',
                        style: TextStyle(
                          color: Color(0xFF6A1B9A),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),

                      // Service Selection Grid
                      Obx(() => GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            childAspectRatio: 1.2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            children:
                                controller.availableServices.map((service) {
                              bool isSelected =
                                  controller.services.contains(service);
                              return GestureDetector(
                                onTap: () => controller.toggleService(service),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isSelected
                                          ? Color(0xFF9C27B0)
                                          : Colors.grey[300]!,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      service == 'Hair'
                                          ? Image.asset('assets/icons/hair.png')
                                          : service == 'Nails'
                                              ? Image.asset(
                                                  'assets/icons/nails.png')
                                              : service == 'Skin'
                                                  ? Image.asset(
                                                      'assets/icons/skin.png')
                                                  : Image.asset(
                                                      'assets/icons/body.png'),
                                      SizedBox(height: 8),
                                      Text(
                                        service,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          )),
                      SizedBox(height: 30),

                      // Working Hours Section
                      Text(
                        'Working Hours',
                        style: TextStyle(
                          color: Color(0xFF6A1B9A),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),

                      // Hours Selector
                      Row(
                        children: [
                          Obx(() => DropdownButton<int>(
                                value: controller.startHour.value,
                                onChanged: (newValue) =>
                                    controller.startHour.value = newValue!,
                                items: List.generate(12, (index) => index + 1)
                                    .map<DropdownMenuItem<int>>((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child:
                                        Text(value.toString().padLeft(2, '0')),
                                  );
                                }).toList(),
                                underline: Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              )),
                          SizedBox(width: 30),
                          Text('To'),
                          SizedBox(width: 30),
                          Obx(() => DropdownButton<int>(
                                value: controller.endHour.value,
                                onChanged: (newValue) =>
                                    controller.endHour.value = newValue!,
                                items: List.generate(12, (index) => index + 1)
                                    .map<DropdownMenuItem<int>>((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child:
                                        Text(value.toString().padLeft(2, '0')),
                                  );
                                }).toList(),
                                underline: Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              )),
                          SizedBox(width: 30),
                          Obx(() => DropdownButton<String>(
                                value: controller.timeFormat.value,
                                onChanged: (newValue) =>
                                    controller.timeFormat.value = newValue!,
                                items: [
                                  'AM',
                                  'PM'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                underline: Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(height: 30),

                      // Working Days Section
                      Text(
                        'Working Days',
                        style: TextStyle(
                          color: Color(0xFF6A1B9A),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),

                      // Days Selector
                      Row(
                        children: [
                          Obx(() => DropdownButton<String>(
                                value: controller.startDay.value,
                                onChanged: (newValue) =>
                                    controller.startDay.value = newValue!,
                                items: controller.weekdays
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                underline: Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              )),
                          SizedBox(width: 30),
                          Text('To'),
                          SizedBox(width: 30),
                          Obx(() => DropdownButton<String>(
                                value: controller.endDay.value,
                                onChanged: (newValue) =>
                                    controller.endDay.value = newValue!,
                                items: controller.weekdays
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                underline: Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(height: 40),

                      Obx(
                        () => CustomButton(
                          text: controller.isLoading.value
                              ? 'Loading'
                              : 'Continue',
                          onPressed: () {
                            controller.submitBusinessProfile();
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              // Loading overlay
              if (controller.isLoading.value)
                Container(
                  color: Colors.black.withValues(alpha: 0.5),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFF9C27B0)),
                    ),
                  ),
                ),
            ],
          )),
    );
  }
}
