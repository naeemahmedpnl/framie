import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/widgets/custom_button.dart';
import '../../../controllers/admin_controllers/all_employee_controller.dart/edit_employee_controller.dart';
import '../../../models/admin_models/all_employees_model.dart';
import '../../../models/salon.response.model.dart';

class EditEmployeeScreen extends StatefulWidget {
  final List<ServiceSalon> serviceSalon;
  final String employeeId;
  final AllEmployees emplyee;
  const EditEmployeeScreen({
    super.key,
    required this.serviceSalon,
    required this.employeeId,
    required this.emplyee,
  });

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  final controller = Get.put(EditEmployeeController());

  @override
  void initState() {
    super.initState();
    controller.selectedIds.clear();
    List<String> employeeServiceIds =
        widget.emplyee.availableServices.map((e) => e.toString()).toList();
    controller.name.text = widget.emplyee.employeeName;
    controller.about.text = widget.emplyee.about;

    for (var service in widget.serviceSalon) {
      if (employeeServiceIds.contains(service.id.toString())) {
        controller.selectedIds.add(service.id.toString());
      }
    }

    controller.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Employee Profile',
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
                      const Text(
                        'Employee Details',
                        style: TextStyle(
                          color: Color(0xFF6A1B9A),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Please confirm your details',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Business Logo
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Obx(() => GestureDetector(
                                onTap: () {
                                  controller.showImageSourceMenu(context);
                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
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
                                      : Image.network(
                                          'https://appsdemo.pro/Framie/${widget.emplyee.employeeImage}',
                                        ),
                                ),
                              )),
                          const SizedBox(width: 10),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              'Upload Employee picture',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Name Field
                      TextField(
                        controller: controller.name,
                        decoration: const InputDecoration(
                          labelText: 'Employee Name',
                          hintText: 'Enter your employee name',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Username Field (Added)
                      TextField(
                        controller: controller.about,
                        decoration: const InputDecoration(
                          labelText: 'About',
                          hintText: 'About',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Available Services Section
                      const Text(
                        'Available Services',
                        style: TextStyle(
                          color: Color(0xFF6A1B9A),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Service Selection Grid
                      // Service Selection Grid
                      Obx(
                        () => GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: widget.serviceSalon.length,
                          itemBuilder: (context, index) {
                            final service = widget.serviceSalon[index];
                            final serviceId = service.id.toString();
                            final isSelected =
                                controller.selectedIds.contains(serviceId);

                            return GestureDetector(
                              onTap: () {
                                if (isSelected) {
                                  controller.selectedIds.remove(serviceId);
                                } else {
                                  controller.selectedIds.add(serviceId);
                                }

                                setState(() {});
                                // Force UI refresh
                                controller.update();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.blue.withOpacity(0.2)
                                      : Colors.white,
                                  border: Border.all(
                                    color:
                                        isSelected ? Colors.blue : Colors.grey,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      'https://appsdemo.pro/Framie/${service.bannerImage}',
                                      height: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(
                                            Icons.image_not_supported,
                                            size: 60);
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      service.title.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: isSelected
                                            ? Colors.blue
                                            : Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Working Hours Section
                      const Text(
                        'Working Hours',
                        style: TextStyle(
                          color: Color(0xFF6A1B9A),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),

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
                          const SizedBox(width: 30),
                          const Text('To'),
                          const SizedBox(width: 30),
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
                          const SizedBox(width: 30),
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
                      const SizedBox(height: 30),

                      // Working Days Section
                      const Text(
                        'Working Days',
                        style: TextStyle(
                          color: Color(0xFF6A1B9A),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),

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
                          const SizedBox(width: 30),
                          const Text('To'),
                          const SizedBox(width: 30),
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
                      const SizedBox(height: 40),

                      Obx(
                        () => CustomButton(
                          text: 'Continue',
                          isLoading: controller.isLoading.value,
                          onPressed: () {
                            if (!controller.isLoading.value) {
                              controller.submitBusinessProfile();
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              // Loading overlay
              if (controller.isLoading.value)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
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
