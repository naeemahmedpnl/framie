import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../views/profile/setting/setting_profile_view.dart';
import '../../views/service_place/booking/booking_view.dart';
import '../../views/service_place/favourites/favourites_view.dart';
import '../../views/service_place/services_by_address/services_by_address_view.dart';

class NavigationController extends GetxController {
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
                  onPressed: () => Navigator.of(context).pop(true),
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
    ServiceByAddressView(),
    BookingDetailsScreen(),
    FavouritesView(),
    SettingProfileView()
  ];
}
