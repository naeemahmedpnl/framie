import 'package:get/get.dart';

class ConfirmBookingController extends GetxController {
  var selectedPaymentMethod = "Mada".obs; // Default selected payment method
  var totalPrice = 88.00.obs; // Total amount to pay

  // Function to change selected payment method
  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }
}