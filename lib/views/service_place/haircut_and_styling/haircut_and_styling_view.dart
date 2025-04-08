import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controllers/services_place_controllers/haircut_and_styling_view_controller/haircut_and_styling_view_controller.dart';
import '../../../models/admin_models/all_employees_model.dart';
import '../../../models/salon.response.model.dart';
import 'salon_details_user_view.dart';

class HairCutAndStylingView extends StatefulWidget {
  final String adminId;
  final String serviceName;
  const HairCutAndStylingView({
    super.key,
    required this.adminId,
    required this.serviceName,
  });

  @override
  State<HairCutAndStylingView> createState() => _HairCutAndStylingViewState();
}

class _HairCutAndStylingViewState extends State<HairCutAndStylingView> {
  final controller = Get.put(HairCutAndStylingController());

  @override
  void initState() {
    super.initState();
    log(widget.adminId);
    controller.fetchEmployees(widget.adminId);
    controller.fetchSalons(widget.adminId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildAppBar(),
              _buildTabBar(),
              Obx(
                () => controller.selectedTab.value == 0
                    ? _buildTreatmentsView()
                    : _buildSalonsView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          Text(
            widget.serviceName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          // Icon(
          //   Icons.favorite_outline,
          //   color: Colors.black,
          // ),
          SizedBox()
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final controller = Get.put(HairCutAndStylingController());
    return Obx(() {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.changeTab(0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: controller.selectedTab.value == 0
                              ? Colors.purple
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      color: controller.selectedTab.value == 0
                          ? Color(0xFFF3E5F5)
                          : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Book By Treatment',
                        style: TextStyle(
                          color: controller.selectedTab.value == 0
                              ? Colors.purple[900]
                              : Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.changeTab(1),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: controller.selectedTab.value == 1
                              ? Colors.purple
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      color: controller.selectedTab.value == 1
                          ? Color(0xFFF3E5F5)
                          : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Stylists',
                        style: TextStyle(
                          color: controller.selectedTab.value == 1
                              ? Colors.purple[900]
                              : Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Availability filter (only shown in Salons tab)
          if (controller.selectedTab.value == 1)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available:',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        controller.availabilityFilter.value,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ],
              ),
            ),
        ],
      );
    });
  }

  Widget _buildTreatmentsView() {
    if (controller.isLoading.value) {
      return Column(
        children: List.generate(
          3,
          (index) => buildShimmerSalonCard(),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          for (ServiceSalon salon in controller.salons)
            _buildTreatmentCard(salon),
        ],
      ),
    );
  }

  Widget buildShimmerSalonCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 96,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 18,
                      width: 120,
                      color: Colors.grey[200],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(width: 4),
                        Container(
                          height: 14,
                          width: 80,
                          color: Colors.grey[200],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.grey[300],
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Container(
                              height: 14,
                              width: 30,
                              color: Colors.grey[200],
                            ),
                            const SizedBox(width: 4),
                            Container(
                              height: 14,
                              width: 40,
                              color: Colors.grey[200],
                            ),
                          ],
                        ),
                        Container(
                          height: 14,
                          width: 50,
                          color: Colors.grey[200],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTreatmentCard(ServiceSalon salon) {
    return InkWell(
      onTap: () {
        // Get.to(() => ViewSubServiceForUser(serviceId: salon.id.toString()));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    'https://appsdemo.pro/Framie/${salon.bannerImage}',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 15,
                  child: Obx(
                    () => CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {
                          controller.toggleFavorite(salon);
                        },
                        icon: Icon(
                          controller.isFavorite(salon)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: controller.isFavorite(salon)
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                salon.title.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildSalonsView() {
  //   return Obx(() {
  //     return GridView.count(
  //       padding: EdgeInsets.all(16),
  //       crossAxisCount: 2,
  //       mainAxisSpacing: 16,
  //       crossAxisSpacing: 16,
  //       childAspectRatio: 0.78,
  //       children: List.generate(controller.employees.length, (index) {
  //         final stylistName = controller.employees[index];
  //         return _buildStylistCard(stylistName);
  //       }),
  //     );
  //   });
  // }

  Widget _buildSalonsView() {
    return Obx(() {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: GridView.count(
          padding: EdgeInsets.all(16),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.78,
          children: List.generate(controller.employees.length, (index) {
            final stylistName = controller.employees[index];
            return _buildStylistCard(stylistName);
          }),
        ),
      );
    });
  }

  Widget _buildStylistCard(AllEmployees employee) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => SalonDetailsUserView(
            employees: employee,
            services: controller.salons,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                'https://appsdemo.pro/Framie/${employee.employeeImage}',
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.employeeName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.purple[900],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '106 Reviews',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '4.98',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
