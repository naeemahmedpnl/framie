import 'package:get/get.dart';

class BookingServicesController extends GetxController {
  var isLoading = false.obs;

  // Dummy service list
  final services = [
    {"title": "Hair Treatments", "image": "assets/images/hair_treatment1.png"},
    {"title": "Hair Treatments", "image": "assets/images/hair_treatment2.png"},
    {"title": "Hair Treatments", "image": "assets/images/hair_treatment3.png"},
    {"title": "Relaxing Massage", "image": "assets/images/booking_screen.png"},
  ].obs;

  void bookService(String serviceName) {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Get.snackbar("Booking Confirmed", "You have booked $serviceName");
    });
  }
}
