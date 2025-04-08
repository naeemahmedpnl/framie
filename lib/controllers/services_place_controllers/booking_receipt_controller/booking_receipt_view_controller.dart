import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/booding_data_model.dart';

class BookingReceiptDetailsController extends GetxController {
  final bookingsData = Rx<BookingData>(
    BookingData(
      id: '#123456789',
      bookingDate: DateTime(2022, 4, 20, 12, 0),
      practitionerName: 'Ray O\'Sun',
      amount: 120,
      status: 'Active',
      subtotal: 251,
      discount: 17,
      tax: 0,
      totalPrice: 249,
      cardholderName: 'Mariah Johana',
      cardNumber: '9432 **** **** ****',
      cardType: 'Mastercard',
    ),
  );

  void confirmBooking() {
    // Implement confirmation logic
    Get.snackbar(
      'Booking Confirmed',
      'Your booking has been confirmed successfully',
      backgroundColor: Color(0xFF8B1F8F).withValues(alpha: 0.2),
      colorText: Color(0xFF8B1F8F),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
