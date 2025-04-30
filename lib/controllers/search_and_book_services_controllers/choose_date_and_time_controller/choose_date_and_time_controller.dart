import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/admin_models/all_employees_model.dart';
import '../../../models/busket_data_model.dart';
import '../../../models/salon.response.model.dart';
import '../../../service/repository/all_employees_repository.dart';
import '../../../service/repository/appointment_repository_user.dart';
import '../../../service/repository/salon_repository.dart';
import '../../../views/nav_menu/navigation_menu.dart';

class ChooseDateTimeController extends GetxController {
  var selectedDate = 0.obs;

  // Sample dates list (You can update this dynamically)
  var dates = [
    {"day": "26", "weekDay": "FRI"},
    {"day": "27", "weekDay": "SAT"},
    {"day": "28", "weekDay": "SUN"},
    {"day": "29", "weekDay": "MON"},
    {"day": "30", "weekDay": "TUE"},
  ].obs;
  var selectedTime = ''.obs;
  @override
  void onInit() {
    super.onInit();
    generateDates();
  }

  String getFormattedDate() {
    if (selectedDate.value >= 0 && selectedDate.value < dates.length) {
      DateTime selectedDateTime =
          DateTime.parse(dates[selectedDate.value]['fullDate'].toString());
      return DateFormat('d-M-yyyy').format(selectedDateTime);
    }
    return '';
  }

  AppointmentRepositoryUser repositoryUser = AppointmentRepositoryUser();
  // Method to submit the business profile
  Future<void> submitBusinessProfile({required BasketDataModel busket}) async {
    isLoading.value = true;

    try {
      // Call the API
      final result = await repositoryUser.bookAppointment(busket: busket);

      isLoading.value = false;

      if (result['success']) {
        Get.snackbar(
          'Success',
          'Service Booked Successfully',
        );
        Get.offAll(() => NavigationMenu());
      } else {
        Get.snackbar(
          'Error',
          result['msg'] ?? 'Failed to add in basket',
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'An unexpected error occurred');
      log('Error adding in basked: $e');
    }
  }

  // Generate dates for 30 days from current date or selected month
  void generateDates() {
    dates.clear();
    final DateFormat dayFormat = DateFormat('dd');
    final DateFormat weekDayFormat = DateFormat('EEE');
    final DateFormat monthFormat = DateFormat('MMMM yyyy');

    // Set current month display
    currentMonth.value = monthFormat.format(currentDisplayDate.value);

    // Generate dates for current month
    DateTime startDate = DateTime(
        currentDisplayDate.value.year, currentDisplayDate.value.month, 1);

    // Get number of days in current month
    int daysInMonth = DateTime(currentDisplayDate.value.year,
            currentDisplayDate.value.month + 1, 0)
        .day;

    // Generate dates
    for (int i = 0; i < daysInMonth; i++) {
      DateTime date = startDate.add(Duration(days: i));
      dates.add({
        'day': dayFormat.format(date),
        'weekDay': weekDayFormat.format(date),
        'fullDate': date.toString(),
      });
    }

    // If we've switched months, reset selectedDate to 0
    if (selectedDate.value >= dates.length) {
      selectedDate.value = 0;
    }
  }

  // Select a specific date
  void selectDate(int index) {
    selectedDate.value = index;
  }

  // Move to previous month
  void previousMonth() {
    currentDisplayDate.value = DateTime(
        currentDisplayDate.value.year, currentDisplayDate.value.month - 1, 1);
    generateDates();
  }

  // Move to next month
  void nextMonth() {
    currentDisplayDate.value = DateTime(
        currentDisplayDate.value.year, currentDisplayDate.value.month + 1, 1);
    generateDates();
  }

  // Current month tracker
  var currentMonth = ''.obs;
  // Current date for month tracking
  var currentDisplayDate = DateTime.now().obs;
  var employees = <AllEmployees>[].obs;
  var isLoadingEmploy = true.obs;
  var salons = <ServiceSalon>[].obs;

  var isLoading = false.obs;
  final SalonRepository _repository = SalonRepository();
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

  // List of stylists (6+ items)
  var stylists = [
    {
      "name": "Ray O’Sun",
      "reviews": "106 Reviews",
      "rating": "4.98",
      "image": "assets/images/stylist1.png"
    },
    {
      "name": "Peter Owt",
      "reviews": "106 Reviews",
      "rating": "4.98",
      "image": "assets/images/stylist2.png"
    },
    {
      "name": "Samantha Lee",
      "reviews": "85 Reviews",
      "rating": "4.90",
      "image": "assets/images/stylist1.png"
    },
    {
      "name": "John Doe",
      "reviews": "120 Reviews",
      "rating": "4.95",
      "image": "assets/images/stylist2.png"
    },
    {
      "name": "Sophia Hill",
      "reviews": "98 Reviews",
      "rating": "4.92",
      "image": "assets/images/stylist1.png"
    },
    {
      "name": "Mike Johnson",
      "reviews": "102 Reviews",
      "rating": "4.97",
      "image": "assets/images/stylist2.png"
    },
  ].obs;
}
