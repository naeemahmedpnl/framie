import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/bussiness_profile_admin.dart';
import '../../../service/repository/sub_repository.dart';

// Controller
class ServiceByAddressViewController extends GetxController {
  final selectedServiceIndex = 0.obs;
  TextEditingController searchController = TextEditingController();
  var bussiness = <BusinessDataAdmin>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSalons();
  }

  void selectService(int index) {
    selectedServiceIndex.value = index;
  }

  final SubSalonRepository _repository = SubSalonRepository();
  RxBool isLoading = false.obs;

  Future<void> fetchSalons() async {
    isLoading.value = true;
    var result = await _repository.fetchAllSalons();
    bussiness.assignAll(result);
    isLoading.value = false;
  }
}
