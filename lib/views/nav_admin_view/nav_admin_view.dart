import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/nav_admin_controller/nav_admin_controller.dart';

class AdminNavigationMenu extends StatelessWidget {
  const AdminNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminNavigationController());
    final Color iconGrey = Colors.grey.shade400;

    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          height: 80,
          child: Obx(
            () {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    imagePath: 'home',
                    label: 'Home',
                    index: 0,
                    currentIndex: controller.selectedIndex.value,
                    onTap: () => controller.selectedIndex.value = 0,
                    iconColor: iconGrey,
                  ),
                  _buildNavItem(
                    imagePath: 'bookings',
                    label: 'Services',
                    index: 1,
                    currentIndex: controller.selectedIndex.value,
                    onTap: () => controller.selectedIndex.value = 1,
                    iconColor: iconGrey,
                  ),
                  _buildNavItem(
                    imagePath: 'Favourite',
                    label: 'Orders',
                    index: 2,
                    currentIndex: controller.selectedIndex.value,
                    onTap: () => controller.selectedIndex.value = 2,
                    iconColor: iconGrey,
                  ),
                  _buildNavItem(
                    imagePath: 'more',
                    label: 'More',
                    index: 3,
                    currentIndex: controller.selectedIndex.value,
                    onTap: () => controller.selectedIndex.value = 3,
                    iconColor: iconGrey,
                  ),
                ],
              );
            },
          ),
        ),
        body: WillPopScope(
          onWillPop: () => controller.ifBackPressed(),
          child: Obx(
            () {
              return controller.screens[controller.selectedIndex.value];
            },
          ),
        ));
  }

  Widget _buildNavItem({
    required String imagePath,
    required String label,
    required int index,
    required int currentIndex,
    required VoidCallback onTap,
    required Color iconColor,
  }) {
    final isSelected = index == currentIndex;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Image.asset(
              'assets/icons/$imagePath.png',
              color: isSelected ? Colors.black : iconColor,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
