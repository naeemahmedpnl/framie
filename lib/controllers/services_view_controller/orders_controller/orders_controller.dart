import 'package:get/get.dart';

import '../../../../models/booking_model.dart';

class OrdersController extends GetxController {
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
    generateSampleBookings();
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
}
