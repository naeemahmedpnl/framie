// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../models/appointment_model.dart';
// import '../../controllers/admin_appointment/admin_appointment_view_controller.dart';

// class AdminAppointmentsView extends StatefulWidget {
//   const AdminAppointmentsView({super.key});

//   @override
//   State<AdminAppointmentsView> createState() => _AdminAppointmentsViewState();
// }

// class _AdminAppointmentsViewState extends State<AdminAppointmentsView> {
//   final controller = Get.put(AdminAppointmentViewController());

//   @override
//   void initState() {
//     super.initState();
//     controller.onInit();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         // leading: IconButton(
//         //   icon: Icon(Icons.arrow_back_ios, color: Colors.black),
//         //   onPressed: () => Get.back(),
//         // ),
//         centerTitle: true,
//         title: Text(
//           'Appointment',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Tab bar
//             Obx(() => Container(
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(color: Colors.grey.shade200),
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () => controller.setActiveTab(0),
//                           child: Container(
//                             padding: EdgeInsets.symmetric(vertical: 16),
//                             decoration: BoxDecoration(
//                               border: Border(
//                                 bottom: BorderSide(
//                                   color: controller.activeTab.value == 0
//                                       ? Color(0xFF8B1F8F)
//                                       : Colors.transparent,
//                                   width: 2,
//                                 ),
//                               ),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 'Upcoming',
//                                 style: TextStyle(
//                                   color: controller.activeTab.value == 0
//                                       ? Color(0xFF8B1F8F)
//                                       : Colors.grey,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () => controller.setActiveTab(1),
//                           child: Container(
//                             padding: EdgeInsets.symmetric(vertical: 16),
//                             decoration: BoxDecoration(
//                               border: Border(
//                                 bottom: BorderSide(
//                                   color: controller.activeTab.value == 1
//                                       ? Color(0xFF8B1F8F)
//                                       : Colors.transparent,
//                                   width: 2,
//                                 ),
//                               ),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 'Past',
//                                 style: TextStyle(
//                                   color: controller.activeTab.value == 1
//                                       ? Color(0xFF8B1F8F)
//                                       : Colors.grey,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
        
//             // Tab content
//             Expanded(
//               child: Obx(
//                 () => controller.activeTab.value == 0
//                     ? _buildUpcomingTab(controller)
//                     : _buildPastTab(controller),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildUpcomingTab(AdminAppointmentViewController controller) {
//     return Column(
//       children: [
//         // Empty state placeholders (similar to the screenshot)

//         Obx(() {
//           if (controller.appointmentData.isEmpty) {
//             return Padding(
//               padding: const EdgeInsets.only(top: 150.0),
//               child: Center(
//                 child: Text('No Appointments'),
//               ),
//             );
//           }
//           if (controller.appointmentData.isEmpty) {
//             return Column(
//               children: List.generate(
//                   4,
//                   (index) => Container(
//                         padding: EdgeInsets.symmetric(horizontal: 20),
//                         margin: EdgeInsets.only(bottom: 16),
//                         height: 80,
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 80,
//                               height: 80,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey.shade200,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             SizedBox(width: 12),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     height: 12,
//                                     width: 120,
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.shade200,
//                                       borderRadius: BorderRadius.circular(4),
//                                     ),
//                                   ),
//                                   SizedBox(height: 8),
//                                   Container(
//                                     height: 12,
//                                     width: 200,
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.shade200,
//                                       borderRadius: BorderRadius.circular(4),
//                                     ),
//                                   ),
//                                   SizedBox(height: 8),
//                                   Container(
//                                     height: 12,
//                                     width: 150,
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.shade200,
//                                       borderRadius: BorderRadius.circular(4),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       )),
//             );
//           }

//           return Column(
//             children: [
//               for (AppointmentData appointment in controller.appointmentData)
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 10,
//                   ),
//                   padding: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Color(0xFFF9F1FA),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     children: [
//                       // Booking ID row
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFF8B1F8F).withValues(
//                                     alpha: 0.1,
//                                   ),
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: Icon(
//                                   Icons.check,
//                                   color: Color(0xFF8B1F8F),
//                                   size: 12,
//                                 ),
//                               ),
//                               SizedBox(width: 12),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'Booking ID',
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(
//                                         appointment.id.length > 5
//                                             ? '${appointment.id.substring(0, 5)}...'
//                                             : appointment.id,
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       SizedBox(width: 10),
//                                       GestureDetector(
//                                         onTap: () {
//                                           Clipboard.setData(ClipboardData(
//                                               text: appointment.id));
//                                           Get.snackbar(
//                                             "Copied",
//                                             "ID copied to clipboard",
//                                             snackPosition: SnackPosition.BOTTOM,
//                                             duration: Duration(seconds: 2),
//                                             backgroundColor: Colors.black,
//                                             colorText: Colors.white,
//                                           );
//                                         },
//                                         child: Icon(
//                                           Icons.copy,
//                                           size: 15,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                           // Booking Date
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   color:
//                                       Color(0xFF8B1F8F).withValues(alpha: 0.1),
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: Icon(
//                                   Icons.calendar_today,
//                                   color: Color(0xFF8B1F8F),
//                                   size: 12,
//                                 ),
//                               ),
//                               SizedBox(width: 12),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Booked On',
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                   Text(
//                                     appointment.date,
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16),

//                       // Divider
//                       Divider(height: 1, color: Colors.grey.shade300),
//                       SizedBox(height: 16),

//                       // Practitioner row
//                       Row(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Color(0xFF8B1F8F).withValues(alpha: 0.1),
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.person,
//                               color: Color(0xFF8B1F8F),
//                               size: 12,
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Practitioners',
//                                 style: TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               Text(
//                                 appointment.clientName,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16),

//                       // Divider
//                       Divider(height: 1, color: Colors.grey.shade300),
//                       SizedBox(height: 16),

//                       // Amount and Date side by side
//                       Row(
//                         children: [
//                           // Amount
//                           Expanded(
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     color: Color(0xFF8B1F8F)
//                                         .withValues(alpha: 0.1),
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Icon(
//                                     Icons.attach_money,
//                                     color: Color(0xFF8B1F8F),
//                                     size: 12,
//                                   ),
//                                 ),
//                                 SizedBox(width: 12),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Total Amount',
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                     Text(
//                                       '\$${appointment.price}',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16),

//                       // Divider
//                       Divider(height: 1, color: Colors.grey.shade300),
//                       SizedBox(height: 16),

//                       // Status and Rebook button row
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           // Status
//                           Row(
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   color:
//                                       Color(0xFF8B1F8F).withValues(alpha: 0.1),
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: Icon(
//                                   Icons.info_outline,
//                                   color: Color(0xFF8B1F8F),
//                                   size: 12,
//                                 ),
//                               ),
//                               SizedBox(width: 12),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Status',
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                   Text(
//                                     appointment.status,
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),

//                           // Rebook button
//                           ElevatedButton(
//                             onPressed: () {
//                               _showStatusUpdateDialog(appointment);
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xFF8B1F8F),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(50),
//                               ),
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 20,
//                                 vertical: 8,
//                               ),
//                             ),
//                             child: Text(
//                               'Update',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//             ],
//           );
//         }),
//       ],
//     );
//   }

//   void _showStatusUpdateDialog(AppointmentData appointment) {
//     String newStatus =
//         appointment.status == 'Pending' ? 'Completed' : 'Pending';

//     Get.dialog(
//       AlertDialog(
//         title: Text('Update Status'),
//         content:
//             Text('Change status from "${appointment.status}" to "$newStatus"?'),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               // Close dialog
//               Get.back();

//               // Show loading indicator
//               Get.dialog(
//                 Center(child: CircularProgressIndicator()),
//                 barrierDismissible: false,
//               );

//               // Prepare data for API call
//               Map<String, dynamic> data = {
//                 "appointmentId": appointment.id,
//                 "status": newStatus
//               };

//               // Call controller method to update status
//               // You'll implement this method in your controller
//               controller.updateAppointmentStatus(data).then((_) {
//                 // Close loading dialog
//                 Get.back();

//                 // Show success message
//                 Get.snackbar(
//                   "Success",
//                   "Appointment status updated successfully",
//                   snackPosition: SnackPosition.BOTTOM,
//                   backgroundColor: Colors.green,
//                   colorText: Colors.white,
//                   duration: Duration(seconds: 2),
//                 );
//               }).catchError((error) {
//                 // Close loading dialog
//                 Get.back();

//                 // Show error message
//                 Get.snackbar(
//                   "Error",
//                   "Failed to update status: ${error.toString()}",
//                   snackPosition: SnackPosition.BOTTOM,
//                   backgroundColor: Colors.red,
//                   colorText: Colors.white,
//                   duration: Duration(seconds: 2),
//                 );
//               });
//             },
//             child: Text('Update'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPastTab(AdminAppointmentViewController controller) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.symmetric(vertical: 16),
//       child: Column(
//         children: [
//           // Booking details card
//           Container(
//             margin: EdgeInsets.all(16),
//             padding: EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Color(0xFFF9F1FA),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Column(
//               children: [
//                 // Booking ID row
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Color(0xFF8B1F8F).withValues(alpha: 0.1),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             Icons.check,
//                             color: Color(0xFF8B1F8F),
//                             size: 12,
//                           ),
//                         ),
//                         SizedBox(width: 12),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Booking ID',
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 12,
//                               ),
//                             ),
//                             Text(
//                               controller.bookingsData.value.id,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),

//                     // Booking Date
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Color(0xFF8B1F8F).withValues(alpha: 0.1),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             Icons.calendar_today,
//                             color: Color(0xFF8B1F8F),
//                             size: 12,
//                           ),
//                         ),
//                         SizedBox(width: 12),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Booked On',
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 12,
//                               ),
//                             ),
//                             Text(
//                               '${DateFormat('dd-MMM-yyyy').format(controller.bookingsData.value.bookingDate)}|${DateFormat('h:mma').format(controller.bookingsData.value.bookingDate)}',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),

//                 // Divider
//                 Divider(height: 1, color: Colors.grey.shade300),
//                 SizedBox(height: 16),

//                 // Practitioner row
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Color(0xFF8B1F8F).withValues(alpha: 0.1),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.person,
//                         color: Color(0xFF8B1F8F),
//                         size: 12,
//                       ),
//                     ),
//                     SizedBox(width: 12),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Practitioners',
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 12,
//                           ),
//                         ),
//                         Text(
//                           controller.bookingsData.value.practitionerName,
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),

//                 // Divider
//                 Divider(height: 1, color: Colors.grey.shade300),
//                 SizedBox(height: 16),

//                 // Amount and Date side by side
//                 Row(
//                   children: [
//                     // Amount
//                     Expanded(
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             padding: EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Color(0xFF8B1F8F).withValues(alpha: 0.1),
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.attach_money,
//                               color: Color(0xFF8B1F8F),
//                               size: 12,
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Total Amount',
//                                 style: TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               Text(
//                                 '\$${controller.bookingsData.value.amount.toStringAsFixed(0)}',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),

//                 // Divider
//                 Divider(height: 1, color: Colors.grey.shade300),
//                 SizedBox(height: 16),

//                 // Status and Rebook button row
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Status
//                     Row(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Color(0xFF8B1F8F).withValues(alpha: 0.1),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             Icons.info_outline,
//                             color: Color(0xFF8B1F8F),
//                             size: 12,
//                           ),
//                         ),
//                         SizedBox(width: 12),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Status',
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 12,
//                               ),
//                             ),
//                             Text(
//                               controller.bookingsData.value.status,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),

//                     // Rebook button
//                     ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFF8B1F8F),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50),
//                         ),
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 20,
//                           vertical: 8,
//                         ),
//                       ),
//                       child: Text(
//                         'Rebook',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 // View Details text
//                 Padding(
//                   padding: EdgeInsets.only(left: 5, top: 20),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: TextButton(
//                       onPressed: () {
//                         // Get.to(() => BookingReceiptDetailsView(appointmentData: null,));
//                       },
//                       style: TextButton.styleFrom(
//                         padding: EdgeInsets.zero,
//                         minimumSize: Size(0, 0),
//                         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                       ),
//                       child: Text(
//                         'View Details',
//                         style: TextStyle(
//                           color: Color(0xFF8B1F8F),
//                           fontSize: 12,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/appointment_model.dart';
import '../../controllers/admin_appointment/admin_appointment_view_controller.dart';

class AdminAppointmentsView extends StatefulWidget {
  const AdminAppointmentsView({super.key});

  @override
  State<AdminAppointmentsView> createState() => _AdminAppointmentsViewState();
}

class _AdminAppointmentsViewState extends State<AdminAppointmentsView>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(AdminAppointmentViewController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    controller.onInit();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      controller.setActiveTab(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Appointment',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF8B1F8F),
          labelColor: const Color(0xFF8B1F8F),
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Past'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUpcomingTab(controller),
          _buildPastTab(controller),
        ],
      ),
    );
  }

  Widget _buildUpcomingTab(AdminAppointmentViewController controller) {
    return Obx(() {
      if (controller.appointmentData.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.event_busy,
                size: 80,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'No Upcoming Appointments',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: controller.appointmentData.length,
        itemBuilder: (context, index) {
          final appointment = controller.appointmentData[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F1FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Booking ID row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B1F8F).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Color(0xFF8B1F8F),
                            size: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Booking ID',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  appointment.id.length > 5
                                      ? '${appointment.id.substring(0, 5)}...'
                                      : appointment.id,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    Clipboard.setData(
                                        ClipboardData(text: appointment.id));
                                    Get.snackbar(
                                      "Copied",
                                      "ID copied to clipboard",
                                      snackPosition: SnackPosition.BOTTOM,
                                      duration: const Duration(seconds: 2),
                                      backgroundColor: Colors.black,
                                      colorText: Colors.white,
                                    );
                                  },
                                  child: const Icon(
                                    Icons.copy,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Booking Date
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B1F8F).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.calendar_today,
                            color: Color(0xFF8B1F8F),
                            size: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Booked On',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              appointment.date,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Divider
                Divider(height: 1, color: Colors.grey.shade300),
                const SizedBox(height: 16),

                // Practitioner row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B1F8F).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Color(0xFF8B1F8F),
                        size: 12,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Practitioners',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          appointment.clientName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Divider
                Divider(height: 1, color: Colors.grey.shade300),
                const SizedBox(height: 16),

                // Amount and Date side by side
                Row(
                  children: [
                    // Amount
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B1F8F).withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.attach_money,
                              color: Color(0xFF8B1F8F),
                              size: 12,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total Amount',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '\$${appointment.price}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Divider
                Divider(height: 1, color: Colors.grey.shade300),
                const SizedBox(height: 16),

                // Status and Update button row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Status
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B1F8F).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.info_outline,
                            color: Color(0xFF8B1F8F),
                            size: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Status',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              appointment.status,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Update button
                    ElevatedButton(
                      onPressed: () {
                        _showStatusUpdateDialog(appointment);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B1F8F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }

  void _showStatusUpdateDialog(AppointmentData appointment) {
    String newStatus =
        appointment.status == 'Pending' ? 'Completed' : 'Pending';

    Get.dialog(
      AlertDialog(
        title: const Text('Update Status'),
        content:
            Text('Change status from "${appointment.status}" to "$newStatus"?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Close dialog
              Get.back();

              // Show loading indicator
              Get.dialog(
                const Center(child: CircularProgressIndicator()),
                barrierDismissible: false,
              );

              // Prepare data for API call
              Map<String, dynamic> data = {
                "appointmentId": appointment.id,
                "status": newStatus,
              };

              // Call controller method to update status
              controller.updateAppointmentStatus(data).then((_) {
                // Close loading dialog
                Get.back();

                // Show success message
                Get.snackbar(
                  "Success",
                  "Appointment status updated successfully",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 2),
                );
              }).catchError((error) {
                // Close loading dialog
                Get.back();

                // Show error message
                Get.snackbar(
                  "Error",
                  "Failed to update status: ${error.toString()}",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 2),
                );
              });
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Widget _buildPastTab(AdminAppointmentViewController controller) {
    return Obx(() {
      if (controller.bookingsData.value.id.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.history,
                size: 80,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'No Past Appointments',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      }

      return ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F1FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Booking ID row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B1F8F).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Color(0xFF8B1F8F),
                            size: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Booking ID',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              controller.bookingsData.value.id,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Booking Date
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B1F8F).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.calendar_today,
                            color: Color(0xFF8B1F8F),
                            size: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Booked On',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '${DateFormat('dd-MMM-yyyy').format(controller.bookingsData.value.bookingDate)} | ${DateFormat('h:mma').format(controller.bookingsData.value.bookingDate)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Divider
                Divider(height: 1, color: Colors.grey.shade300),
                const SizedBox(height: 16),

                // Practitioner row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B1F8F).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Color(0xFF8B1F8F),
                        size: 12,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Practitioners',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          controller.bookingsData.value.practitionerName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Divider
                Divider(height: 1, color: Colors.grey.shade300),
                const SizedBox(height: 16),

                // Amount and Date side by side
                Row(
                  children: [
                    // Amount
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B1F8F).withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.attach_money,
                              color: Color(0xFF8B1F8F),
                              size: 12,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total Amount',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '\$${controller.bookingsData.value.amount.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Divider
                Divider(height: 1, color: Colors.grey.shade300),
                const SizedBox(height: 16),

                // Status and Rebook button row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Status
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B1F8F).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.info_outline,
                            color: Color(0xFF8B1F8F),
                            size: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Status',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              controller.bookingsData.value.status,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Rebook button
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B1F8F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                      ),
                      child: const Text(
                        'Rebook',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                // View Details text
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        // Get.to(() => BookingReceiptDetailsView(appointmentData: null));
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'View Details',
                        style: TextStyle(
                          color: Color(0xFF8B1F8F),
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}