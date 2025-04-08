import 'package:beauty/views/search_and_book_services/booking_service_details_screen/booking_service_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/search_and_book_services_controllers/confirm_booking_controller/confirm_booking_controller.dart';
import '../../../models/admin_models/all_employees_model.dart';
import '../../../models/salon.response.model.dart';

class ConfirmBookingStylistScreen extends StatefulWidget {
  final String serviceName;
  final AllEmployees employees;
  final ServiceSalon services;
  const ConfirmBookingStylistScreen({
    super.key,
    required this.employees,
    required this.services,
    required this.serviceName,
  });

  @override
  State<ConfirmBookingStylistScreen> createState() =>
      _ConfirmBookingStylistScreenState();
}

class _ConfirmBookingStylistScreenState
    extends State<ConfirmBookingStylistScreen> {
  final ConfirmBookingController controller =
      Get.put(ConfirmBookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Confirm Booking",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Details
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://appsdemo.pro/Framie/${widget.employees.employeeImage}',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "USD",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        widget.serviceName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      Text(
                        "Thursday 01 September",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "16:30-17:30(60 Minutes)",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Payment Method
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ListTile(
                  title: const Text(
                    "Payment Method",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Get.bottomSheet(PaymentSelectionSheet(
                      onSelect: (method) {
                        controller.selectPaymentMethod(method);
                      },
                    ));
                  },
                ),
              ),
              const SizedBox(height: 32),

              // Price Details
              _priceRow("Deep tissue massage", "\$ "),
              const SizedBox(height: 16),
              _priceRow("Subtotal", "\$ 88.00"),
              const SizedBox(height: 16),
              _priceRow("Total to pay", "\$ 88.00", isBold: true),
              const SizedBox(height: 32),

              // Apple Pay Option
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/apple.png',
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Pay",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Terms and Privacy
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    children: [
                      const TextSpan(
                        text: "By Booking, you acknowledge and accept\n",
                      ),
                      TextSpan(
                        text: "our terms",
                        style: TextStyle(
                          color: Colors.purple.shade400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(text: " & "),
                      TextSpan(
                        text: "privacy policy",
                        style: TextStyle(
                          color: Colors.purple.shade400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Book & Pay Button
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple.shade700,
                      Colors.purple.shade300,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle booking and payment
                    Get.to( ()=>    BookingServiceDetailsScreen(
                      salon: widget.services,
                      employees: widget.employees,
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    "Book & Pay  £ ${controller.totalPrice.value}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _priceRow(String title, String price, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Colors.black87,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class PaymentSelectionSheet extends StatelessWidget {
  final Function(String) onSelect;

  const PaymentSelectionSheet({
    super.key,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Select Payment Option',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildPaymentOption(),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildSelectButton(),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildPaymentOption() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.purple,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/icons/visaandmastercard.png',
              height: 24,
            ),
          ],
        ),
        trailing: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.purple),
            color: Colors.white,
          ),
          child: const Center(
            child: Icon(
              Icons.check,
              size: 16,
              color: Colors.purple,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.shade700,
            Colors.purple.shade300,
          ],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: ElevatedButton(
        onPressed: () {
          onSelect('card');
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: const Text(
          'Select',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
