import 'dart:developer';

import 'package:beauty/controllers/admin_controllers/all_employee_controller.dart/all_employee_controller.dart';
import 'package:beauty/models/admin_models/all_employees_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/salon.response.model.dart';
import 'create_employee_screen.dart';
import 'edit_employee_profile.dart';

class EmployeeScreen extends StatefulWidget {
  final String adminId;
  const EmployeeScreen({super.key, required this.adminId});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final controller = Get.put(AllEmployeeController());

  @override
  void initState() {
    super.initState();
    log(widget.adminId);
    controller.fetchEmployees(widget.adminId);
    controller.fetchSalons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employees"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.fetchEmployees(widget.adminId);
            },
          ),
        ],
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreateEmployeeScreen(serviceSalon: controller.salons));
          controller.fetchEmployees(widget.adminId);
        },
        shape: CircleBorder(),
        backgroundColor: Colors.purple,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Obx _body() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.employees.isEmpty) {
        return const Center(child: Text("No Employees Available"));
      }

      return ListView.builder(
        itemCount: controller.employees.length,
        itemBuilder: (context, index) {
          final employee = controller.employees[index];

          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Employee Image
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "https://appsdemo.pro/Framie/${employee.employeeImage}",
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/user_placeholder.png',
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: CircleAvatar(
                          backgroundColor: Colors.purple,
                          radius: 20,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Get.to(() => EditEmployeeScreen(
                                    employeeId: employee.id,
                                    emplyee: AllEmployees(
                                      createdBy: employee.id,
                                      employeeImage: employee.employeeImage,
                                      id: employee.id,
                                      employeeName: employee.employeeName,
                                      about: employee.about,
                                      availableServices:
                                          employee.availableServices,
                                      workingDays: employee.workingDays,
                                    ),
                                    serviceSalon: controller.salons,
                                  ));
                            },
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Employee Name
                  Text(
                    employee.employeeName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // About Employee
                  Text(
                    employee.about,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),

                  const SizedBox(height: 10),

                  // Available Services
                  const Text("Services:",
                      style: TextStyle(fontWeight: FontWeight.bold)),

                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (ServiceSalon service in controller.salons.where(
                            (service) => employee.availableServices
                                .contains(service.id)))
                          Chip(label: Text(service.title.toString())),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Working Days
                  const Text("Working Days:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Column(
                    children: employee.workingDays.map((day) {
                      return ListTile(
                        title: Text(day.day),
                        subtitle: Text("${day.startTime} - ${day.endTime}"),
                        leading: Icon(
                          day.isActive ? Icons.check_circle : Icons.cancel,
                          color: day.isActive ? Colors.green : Colors.red,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
