import 'dart:async';
import 'dart:developer';

import 'package:beauty/views/nav_admin_view/nav_admin_view.dart';
import 'package:get/get.dart';

import '/utils/constants/view_consants.dart';
import '../../service/user_session/user_session.dart';
import '../../views/bussiness/bussiness_profile_create_view.dart';
import '../../views/nav_menu/navigation_menu.dart';

class SplashViewController extends GetxController {
  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    timer = Timer(const Duration(seconds: 3), () {
      checkLoginStatus();
    });
  }

  Future<void> checkLoginStatus() async {
    bool isAdmin = await UserSession().getUserType();
    bool loggedIn = await UserSession().isLoggedIn();
    bool isBussinessProfileCreated =
        await UserSession().getBussinessProfileValue();

    if (isAdmin == true) {
      log('This is admin');
      if (isBussinessProfileCreated == false) {
        Get.offAll(() => BusinessProfileCraeteView());
        return;
      }
      Get.offAll(() => AdminNavigationMenu());
      return;
    }

    if (loggedIn) {
      log('User is Logged in');
      checkScreen();
    } else {
      log('User is not Logged in');
      Get.offNamed(kOnboardingViewRoute);
    }
  }

  Future<void> checkScreen() async {
    await UserSession().getUser();
    final userModel = UserSession.userModel.value;

    if (userModel.email!.isEmpty) {
      Get.offNamed(kOnboardingViewRoute);
    } else if (userModel.email!.isNotEmpty && userModel.userType == 'admin') {
      // Get.offAll(() => AdminView());
    } else {
      Get.offAll(() => NavigationMenu());
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
