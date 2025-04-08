import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../views/admin_appointment/admin_appointments.dart';
import '../../views/bussiness/admin/admin_dashboard_view.dart';
import '../../views/profile/setting/setting_profile_view.dart';
import '../../views/services/service_view/service_screen.dart';

class AdminNavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  Future<bool> ifBackPressed() async {
    final shouldExit = await showDialog<bool>(
          context: Get.context!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Exit App"),
              content: const Text("Are you sure you want to exit the app?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("Exit"),
                ),
              ],
            );
          },
        ) ??
        false;
    return Future.value(shouldExit);
  }

  final screens = [
    AdminDashboardScreen(),
    ServiceScreen(),
    AdminAppointmentsView(),
    SettingProfileView()
  ];
}
