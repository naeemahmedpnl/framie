import 'dart:developer';

import 'package:get/get.dart';

import '../../service/user_session/user_session.dart';

class SettingProfileController extends GetxController {
  RxBool isAdmin = false.obs;
  @override
  void onInit() {
    super.onInit();
    getUserType();
  }

  getUserType() async {
    isAdmin.value = await UserSession().getUserType();
    log('Is Admin  $isAdmin ');
  }
}
