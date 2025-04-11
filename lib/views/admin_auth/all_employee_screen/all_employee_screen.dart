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

          return Dismissible(
  key: Key(employee.id),
  direction: DismissDirection.endToStart,
  background: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.redAccent, Colors.red],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.only(right: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Delete',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.delete,
          color: Colors.white,
          size: 24,
        ),
      ],
    ),
  ),
  confirmDismiss: (direction) async {
    return await _showDeleteConfirmationDialog(context);
  },
  onDismissed: (direction) async {
    // Store the deleted employee for potential undo
    final deletedEmployee = employee;
    final deletedIndex = controller.employees.indexOf(employee);
    // Remove the employee from the list temporarily
    controller.employees.removeAt(deletedIndex);

    // Show a snackbar with an undo option
    Get.snackbar(
      'Employee Deleted',
      '${deletedEmployee.employeeName} has been deleted.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
      mainButton: TextButton(
        onPressed: () {
          // Undo the deletion
          controller.employees.insert(deletedIndex, deletedEmployee);
          Get.closeAllSnackbars();
        },
        child: const Text(
          'Undo',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    // Proceed with the API deletion
    await controller.deleteEmployee(employee.id
    // , 
    // onError: () {
    //   // If deletion fails, restore the employee
    //   controller.employees.insert(deletedIndex, deletedEmployee);
    //   Get.snackbar(
    //     'Error',
    //     'Failed to delete employee. Restored.',
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.red,
    //     colorText: Colors.white,
    //   );
    // }
    
    );
  },
  child: Card(
    // Modern card design as provided in your previous message
    color: Colors.white,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    elevation: 6,
    shadowColor: Colors.grey.withOpacity(0.2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Image.network(
                      "https://appsdemo.pro/Framie/${employee.employeeImage}",
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/user_placeholder.png',
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Text(
                  employee.employeeName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        offset: Offset(1, 1),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: CircleAvatar(
                  backgroundColor: const Color(0xFF8B1F8F),
                  radius: 20,
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20,
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
                              availableServices: employee.availableServices,
                              workingDays: employee.workingDays,
                            ),
                            serviceSalon: controller.salons,
                          ))?.then((_) =>
                          controller.fetchEmployees(widget.adminId));
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline,
                color: Color(0xFF8B1F8F),
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  employee.about,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 24,
                ),
                onPressed: () async {
                  final confirm = await _showDeleteConfirmationDialog(context);
                  if (confirm) {
                    // Store the deleted employee for potential undo
                    final deletedEmployee = employee;
                    final deletedIndex = controller.employees.indexOf(employee);
                    // Remove the employee from the list temporarily
                    controller.employees.removeAt(deletedIndex);

                    // Show a snackbar with an undo option
                    Get.snackbar(
                      'Employee Deleted',
                      '${deletedEmployee.employeeName} has been deleted.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 5),
                      mainButton: TextButton(
                        onPressed: () {
                          // Undo the deletion
                          controller.employees
                              .insert(deletedIndex, deletedEmployee);
                          Get.closeAllSnackbars();
                        },
                        child: const Text(
                          'Undo',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );

                    // Proceed with the API deletion
                    await controller.deleteEmployee(employee.id
                    // , onError: () {
                    //   // If deletion fails, restore the employee
                    //   controller.employees
                    //       .insert(deletedIndex, deletedEmployee);
                    //   Get.snackbar(
                    //     'Error',
                    //     'Failed to delete employee. Restored.',
                    //     snackPosition: SnackPosition.BOTTOM,
                    //     backgroundColor: Colors.red,
                    //     colorText: Colors.white,
                    //   );
                    // }
                    );
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.work_outline,
                color: Color(0xFF8B1F8F),
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Services",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: controller.salons
                            .where((service) => employee.availableServices
                                .contains(service.id))
                            .map((service) => Chip(
                                  label: Text(
                                    service.title.toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  backgroundColor:
                                      const Color(0xFF8B1F8F).withOpacity(0.1),
                                  labelStyle: const TextStyle(
                                    color: Color(0xFF8B1F8F),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(
                                      color: Color(0xFF8B1F8F),
                                      width: 0.5,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.calendar_today,
                color: Color(0xFF8B1F8F),
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Working Days",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...employee.workingDays.map((day) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              day.day,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${day.startTime} - ${day.endTime}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  day.isActive
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  color: day.isActive ? Colors.green : Colors.red,
                                  size: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);
          
          
          // Dismissible(
          //   key: Key(employee.id),
          //   direction: DismissDirection.endToStart,
          //   background: Container(
          //     color: Colors.red,
          //     alignment: Alignment.centerRight,
          //     padding: const EdgeInsets.only(right: 20, left: 20),
          //     child: const Icon(
          //       Icons.delete,
          //       color: Colors.white,
          //     ),
          //   ),
          //   confirmDismiss: (direction) async {
          //     return await _showDeleteConfirmationDialog(context);
          //   },
          //   onDismissed: (direction) {
          //     controller.deleteEmployee(employee.id);
          //   },
          //   child: Card(
          //     color: Colors.white,
            
          //     shadowColor: Colors.grey.withOpacity(0.5),
          //     margin: const EdgeInsets.all(10),
          //     elevation: 2,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(12),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           // Employee Image
          //           Stack(
          //             children: [
          //               ClipRRect(
          //                 borderRadius: BorderRadius.circular(10),
          //                 child: Image.network(
          //                   "https://appsdemo.pro/Framie/${employee.employeeImage}",
          //                   height: 150,
          //                   width: double.infinity,
          //                   fit: BoxFit.cover,
          //                   errorBuilder: (context, error, stackTrace) {
          //                     return Image.asset(
          //                       'assets/images/user_placeholder.png',
          //                       height: 150,
          //                       width: double.infinity,
          //                       fit: BoxFit.cover,
          //                     );
          //                   },
          //                 ),
          //               ),
          //               Positioned(
          //                 right: 10,
          //                 top: 10,
          //                 child: CircleAvatar(
          //                   backgroundColor: Colors.purple,
          //                   radius: 20,
          //                   child: IconButton(
          //                     icon: Icon(
          //                       Icons.edit,
          //                       color: Colors.white,
          //                     ),
          //                     onPressed: () {
          //                       Get.to(() => EditEmployeeScreen(
          //                             employeeId: employee.id,
          //                             emplyee: AllEmployees(
          //                               createdBy: employee.id,
          //                               employeeImage: employee.employeeImage,
          //                               id: employee.id,
          //                               employeeName: employee.employeeName,
          //                               about: employee.about,
          //                               availableServices:
          //                                   employee.availableServices,
          //                               workingDays: employee.workingDays,
          //                             ),
          //                             serviceSalon: controller.salons,
          //                           ));
          //                     },
          //                   ),
          //                 ),
          //               )
          //             ],
          //           ),

          //           const SizedBox(height: 12),

          //           // Employee Name and Delete Icon
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 employee.employeeName,
          //                 style: const TextStyle(
          //                   fontSize: 20,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.black87,
          //                 ),
          //               ),
          //               IconButton(
          //                 icon: const Icon(
          //                   Icons.delete,
          //                   color: Colors.red,
          //                   size: 24,
          //                 ),
          //                 onPressed: () async {
          //                   final confirm =
          //                       await _showDeleteConfirmationDialog(context);
          //                   if (confirm) {
          //                     controller.deleteEmployee(employee.id);
          //                   }
          //                 },
          //               ),
          //             ],
          //           ),

          //           // About Employee
          //           Text(
          //             employee.about,
          //             style: const TextStyle(fontSize: 16, color: Colors.grey),
          //           ),

          //           const SizedBox(height: 10),

          //           // Available Services
          //           const Text("Services:",
          //               style: TextStyle(fontWeight: FontWeight.bold)),

          //           Obx(
          //             () => Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 for (ServiceSalon service in controller.salons.where(
          //                     (service) => employee.availableServices
          //                         .contains(service.id)))
          //                   Chip(label: Text(service.title.toString())),
          //               ],
          //             ),
          //           ),

          //           const SizedBox(height: 10),

          //           // Working Days
          //           const Text("Working Days:",
          //               style: TextStyle(fontWeight: FontWeight.bold)),
          //           Column(
          //             children: employee.workingDays.map((day) {
          //               return ListTile(
          //                 title: Text(day.day),
          //                 subtitle: Text("${day.startTime} - ${day.endTime}"),
          //                 leading: Icon(
          //                   day.isActive ? Icons.check_circle : Icons.cancel,
          //                   color: day.isActive ? Colors.green : Colors.red,
          //                 ),
          //               );
          //             }).toList(),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // );
       
       
       
        },
      );
    });
  }

  Future<bool> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Employee'),
            content:
                const Text('Are you sure you want to delete this employee?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
