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

  Future<void> deleteEmployee(String employeeId) async {
    try {
      isLoading(true);
      final result = await _repository.deleteEmployee(employeeId);
      if (result['success']) {
        Get.snackbar(
          'Success',
          result['msg'],
          snackPosition: SnackPosition.BOTTOM,
        
        );
        // Remove the employee from the list
        employees.removeWhere((employee) => employee.id == employeeId);
      } else {
        Get.snackbar(
          'Error',
          result['msg'],
          snackPosition: SnackPosition.BOTTOM,
     
        );
      }
    } catch (e) {
      log('Error deleting employee: $e');
      Get.snackbar(
        'Error',
        'An error occurred while deleting the employee',
        snackPosition: SnackPosition.BOTTOM,
        
      );
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

