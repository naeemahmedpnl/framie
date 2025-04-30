// // import 'package:beauty/models/salon.response.model.dart';
// import 'package:beauty/models/salon.response.model.dart';
// import 'package:beauty/models/sub_services_salon_model.dart';
// import 'package:beauty/views/search_and_book_services/booking_service_details_screen/booking_service_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '/controllers/search_and_book_services_controllers/confirm_booking_controller/confirm_booking_controller.dart';


// class ConfirmBookingStylistScreen extends StatefulWidget {
 
//   final SubService subService;
//   const ConfirmBookingStylistScreen({
//     super.key,

//     required this.subService,

//   });

//   @override
//   State<ConfirmBookingStylistScreen> createState() =>
//       _ConfirmBookingStylistScreenState();
// }

// class _ConfirmBookingStylistScreenState
//     extends State<ConfirmBookingStylistScreen> {
//   final ConfirmBookingController controller =
//       Get.put(ConfirmBookingController());


//   @override
// void initState() {
//   super.initState();
//   controller.totalPrice.value = widget.subService.price;
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.close, color: Colors.black),
//           onPressed: () => Get.back(),
//         ),
//         title: const Text(
//           "Confirm Booking",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(
//               left: 20,
//               right: 20,
//               top: 20,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Service Details
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 30,
//                       backgroundImage: NetworkImage(
//                         'https://appsdemo.pro/Framie/${widget.employees.employeeImage}',
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "USD",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                           ),
//                         ),
//                         Text(
//                           widget.serviceName,
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.purple,
//                           ),
//                         ),
//                         Text(
//                           "Thursday 01 September",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                           ),
//                         ),
//                         Text(
//                           "16:30-17:30(60 Minutes)",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 32),

//                 // Payment Method
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.grey.shade300),
//                   ),
//                   child: ListTile(
//                     title: const Text(
//                       "Payment Method",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     trailing: const Icon(Icons.chevron_right),
//                     onTap: () {
//                       Get.bottomSheet(PaymentSelectionSheet(
//                         onSelect: (method) {
//                           controller.selectPaymentMethod(method);
//                         },
//                       ));
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 32),

//                 // Price Details
//                 _priceRow(widget.serviceName,
//                     "\$${widget.subService.price.toStringAsFixed(2)}"),
//                 const SizedBox(height: 16),
//                 _priceRow("Subtotal",
//                     "\$${widget.subService.price.toStringAsFixed(2)}"),
//                 const SizedBox(height: 16),
//                 _priceRow("Total to pay",
//                     "\$${widget.subService.price.toStringAsFixed(2)}",
//                     isBold: true),
//                 const SizedBox(height: 32),

//                 // Apple Pay Option
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withValues(alpha: 0.05),
//                         blurRadius: 10,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         'assets/icons/apple.png',
//                         height: 24,
//                       ),
//                       const SizedBox(width: 8),
//                       const Text(
//                         "Pay",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 32),

//                 // Terms and Privacy
//                 Center(
//                   child: RichText(
//                     textAlign: TextAlign.center,
//                     text: TextSpan(
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.black87,
//                       ),
//                       children: [
//                         const TextSpan(
//                           text: "By Booking, you acknowledge and accept\n",
//                         ),
//                         TextSpan(
//                           text: "our terms",
//                           style: TextStyle(
//                             color: Colors.purple.shade400,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                         const TextSpan(text: " & "),
//                         TextSpan(
//                           text: "privacy policy",
//                           style: TextStyle(
//                             color: Colors.purple.shade400,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 32),

//                 // Book & Pay Button
//                 Container(
//                   width: double.infinity,
//                   height: 56,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.purple.shade700,
//                         Colors.purple.shade300,
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(28),
//                   ),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Convert SubService to ServiceSalon for compatibility
//                       final salon = ServiceSalon(
//                         id: widget.subService.id,
//                         adminId: widget.subService.adminId,
//                         serviceId: widget.subService.serviceId,
//                         title: widget.subService.title,
//                         text: widget.subService.text,
//                         bannerImage:
//                             widget.subService.subServiceImage.isNotEmpty
//                                 ? widget.subService.subServiceImage.first
//                                 : null,
//                         price: widget.subService.price.toInt(),
//                         createdAt:
//                             widget.subService.createdAt.toIso8601String(),
//                         updatedAt:
//                             widget.subService.updatedAt.toIso8601String(),
//                       );

//                       Get.to(() => BookingServiceDetailsScreen(
//                             salon: salon,
//                             employees: widget.employees,
//                           ));

//                       // Handle booking and payment
//                       // Get.to( ()=>    BookingServiceDetailsScreen(
//                       //   salon: widget.services,
//                       //   employees: widget.employees,
//                       // ));
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.transparent,
//                       shadowColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(28),
//                       ),
//                     ),
//                     child: Text(
//                       "Book & Pay  \$${widget.subService.price.toStringAsFixed(2)}",
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                     // child: Text(
//                     //   "Book & Pay  £ ${controller.totalPrice.value}",
//                     //   style: const TextStyle(
//                     //     fontSize: 18,
//                     //     fontWeight: FontWeight.w600,
//                     //     color: Colors.white,
//                     //   ),
//                     // ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _priceRow(String title, String price, {bool isBold = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: isBold ? 16 : 14,
//             fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//             color: Colors.black87,
//           ),
//         ),
//         Text(
//           price,
//           style: TextStyle(
//             fontSize: isBold ? 16 : 14,
//             fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//             color: Colors.black87,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class PaymentSelectionSheet extends StatelessWidget {
//   final Function(String) onSelect;

//   const PaymentSelectionSheet({
//     super.key,
//     required this.onSelect,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 16, bottom: 16),
//       child: Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const SizedBox(height: 20),
//             const Text(
//               'Select Payment Option',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 24),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: _buildPaymentOption(),
//             ),
//             const SizedBox(height: 24),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: _buildSelectButton(),
//             ),
//             const SizedBox(height: 32),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPaymentOption() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.purple,
//           width: 1,
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         leading: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.asset(
//               'assets/icons/visaandmastercard.png',
//               height: 24,
//             ),
//           ],
//         ),
//         trailing: Container(
//           width: 24,
//           height: 24,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(color: Colors.purple),
//             color: Colors.white,
//           ),
//           child: const Center(
//             child: Icon(
//               Icons.check,
//               size: 16,
//               color: Colors.purple,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSelectButton() {
//     return Container(
//       width: double.infinity,
//       height: 56,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Colors.purple.shade700,
//             Colors.purple.shade300,
//           ],
//         ),
//         borderRadius: BorderRadius.circular(28),
//       ),
//       child: ElevatedButton(
//         onPressed: () {
//           onSelect('card');
//           Get.back();
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(28),
//           ),
//         ),
//         child: const Text(
//           'Select',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:beauty/models/sub_services_salon_model.dart';
import 'package:beauty/views/search_and_book_services/booking_service_details_screen/booking_service_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/search_and_book_services_controllers/confirm_booking_controller/confirm_booking_controller.dart';

class ConfirmBookingStylistScreen extends StatefulWidget {
  final SubService subService;
  
  const ConfirmBookingStylistScreen({
    Key? key,
    required this.subService,
  }) : super(key: key);

  @override
  State<ConfirmBookingStylistScreen> createState() =>
      _ConfirmBookingStylistScreenState();
}

class _ConfirmBookingStylistScreenState
    extends State<ConfirmBookingStylistScreen> {
  final ConfirmBookingController controller =
      Get.put(ConfirmBookingController());
  
  AssignedEmployee? selectedEmployee;
  
  @override
  void initState() {
    super.initState();
    controller.totalPrice.value = widget.subService.price;
    
    // Auto-select the first employee if available
    if (widget.subService.assignedTo.isNotEmpty) {
      selectedEmployee = widget.subService.assignedTo.first;
    }
  }

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service Details
                Row(
                  children: [
                    if (selectedEmployee != null)
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'https://appsdemo.pro/Framie/${selectedEmployee!.employeeImage}',
                        ),
                        onBackgroundImageError: (_, __) => const Icon(Icons.person),
                      )
                    else
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "USD",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          widget.subService.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                        const Text(
                          "Thursday 01 September",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const Text(
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

                // Employee Selection if there are multiple assigned employees
                if (widget.subService.assignedTo.length > 1)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Stylist",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.subService.assignedTo.length,
                          itemBuilder: (context, index) {
                            final employee = widget.subService.assignedTo[index];
                            final isSelected = selectedEmployee?.id == employee.id;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedEmployee = employee;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 12),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected ? Colors.purple : Colors.grey.shade300,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                        'https://appsdemo.pro/Framie/${employee.employeeImage}',
                                      ),
                                      onBackgroundImageError: (_, __) => const Icon(Icons.person),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      employee.employeeName,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),

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
                _priceRow(widget.subService.title,
                    "\$${widget.subService.price.toStringAsFixed(2)}"),
                const SizedBox(height: 16),
                _priceRow("Subtotal",
                    "\$${widget.subService.price.toStringAsFixed(2)}"),
                const SizedBox(height: 16),
                _priceRow("Total to pay",
                    "\$${widget.subService.price.toStringAsFixed(2)}",
                    isBold: true),
                const SizedBox(height: 32),

                // Apple Pay Option
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
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
                      // Directly pass the subService model to the next screen
                      Get.to(() => BookingServiceDetailsScreen(
                            subService: widget.subService,
                            // selectedEmployee: selectedEmployee,
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      disabledBackgroundColor: Colors.grey.withOpacity(0.5),
                    ),
                    child: Text(
                      "Book & Pay  \$${widget.subService.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
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
    Key? key,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
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