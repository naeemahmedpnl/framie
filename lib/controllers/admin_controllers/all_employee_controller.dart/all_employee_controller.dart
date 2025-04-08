import 'dart:developer';

import 'package:beauty/models/admin_models/all_employees_model.dart';
import 'package:beauty/service/repository/all_employees_repository.dart';
import 'package:get/get.dart';

import '../../../models/salon.response.model.dart';
import '../../../service/repository/salon_repository.dart';

class AllEmployeeController extends GetxController {
  var employees = <AllEmployees>[].obs;
  var isLoading = true.obs;
  var salons = <ServiceSalon>[].obs;
  var isLoadingSalon = false.obs;

  final AllEmployeesRepository _repository = AllEmployeesRepository();

  void fetchEmployees(String adminId) async {
    try {
      isLoading(true);
      var fetchedEmployees = await _repository.fetchAllEmployees(adminId);
      employees.assignAll(fetchedEmployees);
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  final SalonRepository _repositorySalons = SalonRepository();

  Future<void> fetchSalons() async {
    isLoadingSalon.value = true;
    var result = await _repositorySalons.fetchAllSalons();
    salons.assignAll(result);
    isLoadingSalon.value = false;
  }
}
