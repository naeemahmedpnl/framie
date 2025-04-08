import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/admin_models/all_employees_model.dart';
import '../../../models/salon.response.model.dart';
import '../../../service/repository/all_employees_repository.dart';
import '../../../service/repository/salon_repository.dart';

class HairCutAndStylingController extends GetxController {
  var selectedTab = 0.obs;
  var availabilityFilter = "Today".obs;
  var salons = <ServiceSalon>[].obs;
  var isLoading = false.obs;
  var employees = <AllEmployees>[].obs;
  var isLoadingEmploy = true.obs;
  final SalonRepository _repository = SalonRepository();

  @override
  void onInit() {
    loadFavorites();
    super.onInit();
  }

  var favorites = <String>[].obs;
  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList('favorites');
    if (data != null) {
      favorites.addAll(data);
    }
  }

  Future<void> toggleFavorite(ServiceSalon salon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String salonJson = jsonEncode(salon.toJson());

    if (favorites.contains(salonJson)) {
      favorites.remove(salonJson);
    } else {
      favorites.add(salonJson);
    }

    await prefs.setStringList('favorites', favorites);
    update();
  }

  bool isFavorite(ServiceSalon salon) {
    String salonJson = jsonEncode(salon.toJson());
    return favorites.contains(salonJson);
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void setAvailabilityFilter(String filter) {
    availabilityFilter.value = filter;
  }

  final AllEmployeesRepository _repositoryEmployees = AllEmployeesRepository();

  void fetchEmployees(String adminId) async {
    try {
      isLoadingEmploy(true);
      List<AllEmployees> fetchedEmployees =
          await _repositoryEmployees.fetchAllEmployees(adminId);
      employees.assignAll(fetchedEmployees);
    } catch (e) {
      log(e.toString());
    } finally {
      isLoadingEmploy(false);
    }
  }

  Future<void> fetchSalons(String adminId) async {
    isLoading.value = true;
    var result = await _repository.fetchAllSalonsServicesById(adminId);
    salons.assignAll(result);
    isLoading.value = false;
  }
}
