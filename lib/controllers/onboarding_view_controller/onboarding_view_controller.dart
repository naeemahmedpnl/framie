import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingViewController extends GetxController {
  static OnboardingViewController get instance => Get.find();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
}
