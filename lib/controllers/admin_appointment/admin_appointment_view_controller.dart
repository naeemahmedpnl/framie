import 'dart:developer';

import 'package:get/get.dart';

import '../../../models/appointment_model.dart';
import '../../../models/booking_model.dart';
import '../../service/repository/admin_auth_repository/admin_appointment_repository.dart';

class AdminAppointmentViewController extends GetxController {
  var bookings = <Booking>[].obs;
  var selectedTab = 0.obs;
  // Active tab (0 = Upcoming, 1 = Past)
  final activeTab = 0.obs;

  void setActiveTab(int tab) {
    activeTab.value = tab;
  }

  @override
  void onInit() {
    super.onInit();
    // Populate with sample data
    fetchEmployees();
    generateSampleBookings();
  }

  Future<void> updateAppointmentStatus(Map<String, dynamic> data) async {
    try {
      isLoading(true);
      await appointmentRepo.updateAppointment(
        appointmentId: data['appointmentId'],
        status: data['status'],
      );
      fetchEmployees();
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  var bookingsData = Booking(
    id: '#123456789',
    practitionerName: 'Ray O\'Sun',
    amount: 120.0,
    bookingDate: DateTime(2022, 4, 20, 12, 0),
    status: 'Active',
  ).obs;
  void generateSampleBookings() {
    bookings.add(
      Booking(
        id: '#123456789',
        practitionerName: 'Ray O\'Sun',
        amount: 120.0,
        bookingDate: DateTime(2022, 4, 20, 12, 0),
        status: 'Active',
      ),
    );
  }

  List<Booking> get upcomingBookings => bookings
      .where((booking) => booking.bookingDate.isAfter(DateTime.now()))
      .toList();

  List<Booking> get pastBookings => bookings
      .where((booking) => !booking.bookingDate.isAfter(DateTime.now()))
      .toList();

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void bookNow() {
    // Implementation for booking new appointment
    Get.snackbar(
      'Booking',
      'Opening booking form...',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void rebookAppointment(Booking booking) {
    // Implementation for rebooking
    Get.snackbar(
      'Rebooking',
      'Rebooking appointment ${booking.id}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  RxBool isLoading = false.obs;

  AdminAppointmentRepositoryUser appointmentRepo =
      AdminAppointmentRepositoryUser();
  var appointmentData = <AppointmentData>[].obs;

  void fetchEmployees() async {
    try {
      isLoading(true);
      var fetchedEmployees = await appointmentRepo.fetchAllEmployees();
      appointmentData.assignAll(fetchedEmployees);
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
