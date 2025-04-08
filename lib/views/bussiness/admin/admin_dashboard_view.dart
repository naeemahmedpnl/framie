import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '/utils/widgets/custom_button.dart';
import '../../../controllers/bussiness/admin/admin_dashboard_view_controller.dart';
import '../../admin_appointment/admin_appointments.dart';
import '../../services/add_service/add_service.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminDashboardController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildTimeframeSelector(),
                const SizedBox(height: 10),
                _buildMainStats(),
                const SizedBox(height: 24),
                _buildSecondaryStats(),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildCreateServiceButton(),
    );
  }

  Widget _buildHeader() {
    final controller = Get.put(AdminDashboardController());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(Icons.location_on_outlined, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Location',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
              Obx(
                () => Row(
                  children: [
                    Text(
                      controller.location.value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 12),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {
                    Get.to(() => AdminAppointmentsView());
                  },
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeframeSelector() {
    final controller = Get.find<AdminDashboardController>();

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF4A0072),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(
            () => _timeframeOption('Day',
                isSelected: controller.selectedTimeframe.value == 'Day'),
          ),
          Obx(
            () => _timeframeOption('Week',
                isSelected: controller.selectedTimeframe.value == 'Week'),
          ),
          Obx(
            () => _timeframeOption('Month',
                isSelected: controller.selectedTimeframe.value == 'Month'),
          ),
        ],
      ),
    );
  }

  Widget _timeframeOption(String title, {required bool isSelected}) {
    final controller = Get.find<AdminDashboardController>();

    return GestureDetector(
      onTap: () => controller.changeTimeframe(title),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFF4A0072) : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildMainStats() {
    final controller = Get.put(AdminDashboardController());

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Color(0xFF4A0072)),
                onPressed: () => controller.navigateMonth(false),
              ),
              Obx(() => Text(
                    controller.currentMonth.value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A0072),
                    ),
                  )),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: Color(0xFF4A0072)),
                onPressed: () => controller.navigateMonth(true),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Obx(() => CircularPercentIndicator(
                radius: 120,
                lineWidth: 15,
                percent: controller.customerProgress,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${controller.customerCount}',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A0072),
                      ),
                    ),
                    const Text(
                      'Customer this month',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                progressColor: const Color(0xFF4A0072),
                backgroundColor: Colors.white,
                circularStrokeCap: CircularStrokeCap.round,
              )),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A0072),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.sentiment_satisfied_alt,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "You're doing good!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A0072),
                      ),
                    ),
                    Text(
                      "You almost reached your goal",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryStats() {
    final controller = Get.put(AdminDashboardController());

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: 35,
            lineWidth: 8,
            percent: 0.6,
            center: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/person_image.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            progressColor: const Color(0xFF4A0072),
            backgroundColor: Colors.grey[200]!,
            circularStrokeCap: CircularStrokeCap.round,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Text(
                    '${controller.visitorCount}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A0072),
                    ),
                  )),
              const Text(
                'Visitors this month',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreateServiceButton() {
    return CustomButton(
      onPressed: () {
        // Get.to(() => CreateProfileServiceProfileCreateView());
        Get.to(() => AddServiceScreen());
      },
      width: 200,
      text: 'Create Service',
    );
  }
}
