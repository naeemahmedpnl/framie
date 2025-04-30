// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';

// // import '/controllers/search_and_book_services_controllers/choose_date_and_time_controller/choose_date_and_time_controller.dart';
// // import '../../../models/admin_models/all_employees_model.dart';
// // import '../../../models/busket_data_model.dart';
// // import '../../../models/salon.response.model.dart';
// // import '../../../service/user_session/user_session.dart';
// // import '../../service_place/haircut_and_styling/salon_details_user_view.dart';

// // class ChooseDateTimeScreen extends StatefulWidget {

// //   const ChooseDateTimeScreen({
// //     super.key,

// //   });

// //   @override
// //   State<ChooseDateTimeScreen> createState() => _ChooseDateTimeScreenState();
// // }

// // class _ChooseDateTimeScreenState extends State<ChooseDateTimeScreen> {
// //   final controller = Get.put(ChooseDateTimeController());

// //   @override
// //   void initState() {
// //     super.initState();
// //     controller.fetchEmployees(widget.adminId);
// //     controller.fetchSalons(widget.adminId);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         leading: IconButton(
// //           icon: const Icon(
// //             Icons.arrow_back_ios,
// //             color: Colors.black,
// //           ),
// //           onPressed: () => Get.back(),
// //         ),
// //         title: const Text("Choose Date & Time"),
// //         centerTitle: true,
// //       ),
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             Container(
// //               color: Colors.purple,
// //               width: double.infinity,
// //               padding: const EdgeInsets.symmetric(vertical: 10),
// //               child: Column(
// //                 children: [
// //                   // Month Name
// //                   Obx(
// //                     () => Text(
// //                       controller.currentMonth.value,
// //                       style: const TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 8),

// //                   // Date Selector Row
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       // Left Arrow
// //                       IconButton(
// //                         icon: const Icon(Icons.arrow_left, color: Colors.white),
// //                         onPressed: () => controller.previousMonth(),
// //                       ),

// //                       // Date List
// //                       Expanded(
// //                         child: Obx(
// //                           () => SingleChildScrollView(
// //                             scrollDirection: Axis.horizontal,
// //                             child: Row(
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               children:
// //                                   List.generate(controller.dates.length, (index) {
// //                                 var date = controller.dates[index];
// //                                 bool isSelected =
// //                                     index == controller.selectedDate.value;

// //                                 return GestureDetector(
// //                                   onTap: () async {
// //                                     controller.selectDate(index);
// //                                     // Show Time Picker
// //                                     TimeOfDay? pickedTime = await showTimePicker(
// //                                       context: context,
// //                                       initialTime: TimeOfDay.now(),
// //                                     );

// //                                     if (pickedTime != null) {
// //                                       controller.selectedTime.value =
// //                                           pickedTime.format(Get.context!);
// //                                       showBottomSheetView(Get.context!);
// //                                     }
// //                                   },
// //                                   child: Padding(
// //                                     padding: const EdgeInsets.symmetric(
// //                                       horizontal: 16,
// //                                     ),
// //                                     child: Column(
// //                                       children: [
// //                                         Text(
// //                                           date["day"]!,
// //                                           style: TextStyle(
// //                                             color: isSelected
// //                                                 ? Colors.white
// //                                                 : Colors.white70,
// //                                             fontSize: 18,
// //                                             fontWeight: FontWeight.bold,
// //                                           ),
// //                                         ),
// //                                         Text(
// //                                           date["weekDay"]!,
// //                                           style: TextStyle(
// //                                             color: isSelected
// //                                                 ? Colors.white
// //                                                 : Colors.white60,
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 );
// //                               }),
// //                             ),
// //                           ),
// //                         ),
// //                       ),

// //                       // Right Arrow
// //                       IconButton(
// //                         icon: const Icon(Icons.arrow_right, color: Colors.white),
// //                         onPressed: () => controller.nextMonth(),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(height: 16),

// //             // Available Stylists Title
// //             const Padding(
// //               padding: EdgeInsets.symmetric(horizontal: 16),
// //               child: Align(
// //                 alignment: Alignment.center,
// //                 child: Text("Available Stylists",
// //                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// //               ),
// //             ),

// //             const SizedBox(height: 10),

// //             // Available Stylists List
// //             Expanded(
// //               child: _buildSalonsView(),
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildSalonsView() {
// //     return Obx(() {
// //       if (controller.employees.isEmpty) {
// //         return const Center(child: CircularProgressIndicator());
// //       }

// //       return GridView.builder(
// //         padding: const EdgeInsets.all(16),
// //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //           crossAxisCount: 2,
// //           mainAxisSpacing: 16,
// //           crossAxisSpacing: 16,
// //           childAspectRatio: 0.78,
// //         ),
// //         itemCount: controller.employees.length,
// //         itemBuilder: (context, index) {
// //           final employee = controller.employees[index];
// //           return _buildStylistCard(employee);
// //         },
// //       );
// //     });
// //   }

// //   Widget _buildStylistCard(AllEmployees employee) {
// //     return GestureDetector(
// //       onTap: () {
// //         Get.to(
// //           () => SalonDetailsUserView(
// //             employees: employee,
// //             services: controller.salons,
// //             adminId: widget.adminId,
// //           ),
// //         );
// //       },
// //       child: Container(

// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(12),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black.withValues(alpha: 0.05),
// //               blurRadius: 10,
// //               offset: const Offset(0, 5),
// //             ),
// //           ],
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             ClipRRect(
// //               borderRadius:
// //                   const BorderRadius.vertical(top: Radius.circular(12)),
// //               child: Image.network(
// //                 'https://appsdemo.pro/Framie/${employee.employeeImage}',
// //                 height: 120,
// //                 width: double.infinity,
// //                 fit: BoxFit.cover,
// //                 errorBuilder: (context, error, stackTrace) {
// //                   return Container(
// //                     height: 140,
// //                     width: double.infinity,
// //                     color: Colors.grey[300],
// //                     child: const Icon(Icons.error),
// //                   );
// //                 },
// //               ),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(8),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     employee.employeeName,
// //                     style: TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.w600,
// //                       color: Colors.purple[900],
// //                     ),
// //                     maxLines: 1,
// //                     overflow: TextOverflow.ellipsis,
// //                   ),
// //                   const SizedBox(height: 4),
// //                   Text(
// //                     '106 Reviews',
// //                     style: TextStyle(
// //                       fontSize: 12,
// //                       color: Colors.grey[600],
// //                     ),
// //                   ),
// //                   const SizedBox(height: 4),
// //                   Row(
// //                     children: [
// //                       const Icon(
// //                         Icons.star,
// //                         color: Colors.amber,
// //                         size: 16,
// //                       ),
// //                       const SizedBox(width: 4),
// //                       const Text(
// //                         '4.98',
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.amber,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // Function to show Bottom Sheet
// //   void showBottomSheetView(BuildContext context) {
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.white,
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
// //       ),
// //       builder: (context) {
// //         return Padding(
// //           padding: const EdgeInsets.only(
// //             bottom: 35,
// //             left: 16,
// //             right: 16,
// //             top: 20,
// //           ),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               // Title
// //               Text(
// //                 "Your Basket",
// //                 style: TextStyle(
// //                   fontSize: 18,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),

// //               const SizedBox(height: 10),

// //               // Service Item with Remove Button
// //               Container(
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(12),
// //                   border: Border.all(color: Colors.grey.shade300),
// //                 ),
// //                 child: ListTile(
// //                   leading: ClipRRect(
// //                     borderRadius: BorderRadius.circular(8),
// //                     child: Image.network(
// //                       "https://appsdemo.pro/Framie/${widget.salon.bannerImage}",
// //                       width: 50,
// //                       height: 50,
// //                       fit: BoxFit.cover,
// //                     ),
// //                   ),
// //                   title: Text(
// //                     widget.salon.title.toString(),
// //                     style: TextStyle(
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                   subtitle: Text(
// //                     "60 Minutes",
// //                     style: TextStyle(
// //                       color: Colors.grey.shade600,
// //                     ),
// //                   ),
// //                   trailing: Icon(
// //                     Icons.close,
// //                     color: Colors.grey,
// //                   ),
// //                   onTap: () {
// //                     Get.back();
// //                   },
// //                 ),
// //               ),

// //               const SizedBox(height: 20),

// //               // Choose Date & Time Button
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     padding: EdgeInsets.symmetric(vertical: 15),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(30),
// //                     ),
// //                     backgroundColor: Colors.purple,
// //                     foregroundColor: Colors.white,
// //                     textStyle: TextStyle(fontSize: 16),
// //                   ),
// //                   onPressed: () async {
// //                     BasketDataModel basket = BasketDataModel(
// //                       userId: UserSession.userModel.value.id,
// //                       adminId: widget.salon.adminId.toString(),
// //                       clientName: UserSession.userModel.value.name.toString(),
// //                       date: controller.getFormattedDate(),

// //                       timeSlot: controller.selectedTime.toString(),
// //                       price: '60',
// //                       createdByModel: "Admin",
// //                       createdBy: widget.salon.adminId.toString(),
// //                       services: [widget.salon.id.toString()],
// //                     );

// //                     controller.submitBusinessProfile(
// //                       busket: basket,
// //                     );
// //                   },
// //                   child: Text("Add in Basket"),
// //                 ),
// //               ),

// //               const SizedBox(height: 10),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import 'package:beauty/models/sub_services_salon_model.dart';
// import 'package:beauty/models/busket_data_model.dart';
// import 'package:beauty/service/user_session/user_session.dart';
// import 'package:beauty/controllers/search_and_book_services_controllers/choose_date_and_time_controller/choose_date_and_time_controller.dart';

// class ChooseDateTimeScreen extends StatefulWidget {
//   final SubService subService;
//   final AssignedEmployee? selectedEmployee;
//   final String duration;

//   const ChooseDateTimeScreen({
//     Key? key,
//     required this.subService,
//     this.selectedEmployee,
//     required this.duration,
//   }) : super(key: key);

//   @override
//   State<ChooseDateTimeScreen> createState() => _ChooseDateTimeScreenState();
// }

// class _ChooseDateTimeScreenState extends State<ChooseDateTimeScreen> {
//   final controller = Get.put(ChooseDateTimeController());

//   @override
//   void initState() {
//     super.initState();

//     controller.fetchEmployees(widget.subService.adminId);

//     // SubService ka data print kar rahe hain
//     log("SubService Title: ${widget.subService.title}");
//     log("Admin ID: ${widget.subService.adminId}");
//     log("SubService Image List: ${widget.subService.subServiceImage}");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//           onPressed: () => Get.back(),
//         ),
//         title: const Text("Choose Date & Time"),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               color: Colors.purple,
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               child: Column(
//                 children: [
//                   // Month Name
//                   Obx(
//                     () => Text(
//                       controller.currentMonth.value,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),

//                   // Date Selector Row
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Left Arrow
//                       IconButton(
//                         icon: const Icon(Icons.arrow_left, color: Colors.white),
//                         onPressed: () => controller.previousMonth(),
//                       ),

//                       // Date List
//                       Expanded(
//                         child: Obx(
//                           () => SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: List.generate(controller.dates.length,
//                                   (index) {
//                                 var date = controller.dates[index];
//                                 bool isSelected =
//                                     index == controller.selectedDate.value;

//                                 return GestureDetector(
//                                   onTap: () async {
//                                     controller.selectDate(index);
//                                     // Show Time Picker
//                                     TimeOfDay? pickedTime =
//                                         await showTimePicker(
//                                       context: context,
//                                       initialTime: TimeOfDay.now(),
//                                     );

//                                     if (pickedTime != null) {
//                                       controller.selectedTime.value =
//                                           pickedTime.format(Get.context!);
//                                       showBottomSheetView(Get.context!);
//                                     }
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 16,
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         Text(
//                                           date["day"]!,
//                                           style: TextStyle(
//                                             color: isSelected
//                                                 ? Colors.white
//                                                 : Colors.white70,
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         Text(
//                                           date["weekDay"]!,
//                                           style: TextStyle(
//                                             color: isSelected
//                                                 ? Colors.white
//                                                 : Colors.white60,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               }),
//                             ),
//                           ),
//                         ),
//                       ),

//                       // Right Arrow
//                       IconButton(
//                         icon:
//                             const Icon(Icons.arrow_right, color: Colors.white),
//                         onPressed: () => controller.nextMonth(),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Service Details Card
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: _buildServiceDetailsCard(),
//             ),

//             const SizedBox(height: 20),

//             // Stylist Information (if available)
//             if (widget.selectedEmployee != null)
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: _buildStylistInfoCard(),
//               ),

//             const SizedBox(height: 20),

//             // Time Slots Display (if date selected but no time)
//             Obx(() {
//               if (controller.selectedDate.value != -1 &&
//                   controller.selectedTime.value.isEmpty) {
//                 return _buildTimeSlotGrid();
//               }
//               return const SizedBox.shrink();
//             }),

//             const Spacer(),

//             // Booking Button
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 55,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.purple,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   onPressed: controller.selectedTime.value.isEmpty
//                       ? null
//                       : () {
//                           showBottomSheetView(context);
//                         },
//                   child: const Text(
//                     "Confirm Selection",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildServiceDetailsCard() {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Service Details",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.purple,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 if (widget.subService.subServiceImage.isNotEmpty)
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.network(
//                       "https://appsdemo.pro/Framie/${widget.subService.subServiceImage.first}",
//                       width: 70,
//                       height: 70,
//                       fit: BoxFit.cover,
//                       errorBuilder: (_, __, ___) => Container(
//                         width: 70,
//                         height: 70,
//                         color: Colors.grey[300],
//                         child: const Icon(Icons.image_not_supported, size: 25),
//                       ),
//                     ),
//                   )
//                 else
//                   Container(
//                     width: 70,
//                     height: 70,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Icon(Icons.image_not_supported, size: 25),
//                   ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.subService.title,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         widget.duration,
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "\$${widget.subService.price.toStringAsFixed(2)}",
//                         style: const TextStyle(
//                           color: Colors.purple,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStylistInfoCard() {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Selected Stylist",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.purple,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.network(
//                     "https://appsdemo.pro/Framie/${widget.selectedEmployee!.employeeImage}",
//                     width: 70,
//                     height: 70,
//                     fit: BoxFit.cover,
//                     errorBuilder: (_, __, ___) => Container(
//                       width: 70,
//                       height: 70,
//                       color: Colors.grey[300],
//                       child: const Icon(Icons.person, size: 25),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.selectedEmployee!.employeeName,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         widget.selectedEmployee!.about,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTimeSlotGrid() {
//     final List<String> timeSlots = [
//       '9:00 AM',
//       '10:00 AM',
//       '11:00 AM',
//       '12:00 PM',
//       '1:00 PM',
//       '2:00 PM',
//       '3:00 PM',
//       '4:00 PM',
//       '5:00 PM',
//     ];

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Select Time",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Wrap(
//             spacing: 10,
//             runSpacing: 10,
//             children: timeSlots.map((time) {
//               return GestureDetector(
//                 onTap: () {
//                   controller.selectedTime.value = time;
//                 },
//                 child: Container(
//                   width: (MediaQuery.of(context).size.width - 52) / 3,
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.grey.shade300),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Center(
//                     child: Text(
//                       time,
//                       style: const TextStyle(
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   // Function to show Bottom Sheet
//   void showBottomSheetView(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.only(
//             bottom: 35,
//             left: 16,
//             right: 16,
//             top: 20,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Title
//               const Text(
//                 "Your Basket",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 10),

//               // Service Item with Remove Button
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//                 child: ListTile(
//                   leading: ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: widget.subService.subServiceImage.isNotEmpty
//                         ? Image.network(
//                             "https://appsdemo.pro/Framie/${widget.subService.subServiceImage.first}",
//                             width: 50,
//                             height: 50,
//                             fit: BoxFit.cover,
//                             errorBuilder: (_, __, ___) => Container(
//                               width: 50,
//                               height: 50,
//                               color: Colors.grey[300],
//                               child: const Icon(Icons.image_not_supported,
//                                   size: 20),
//                             ),
//                           )
//                         : Container(
//                             width: 50,
//                             height: 50,
//                             color: Colors.grey[300],
//                             child:
//                                 const Icon(Icons.image_not_supported, size: 20),
//                           ),
//                   ),
//                   title: Text(
//                     widget.subService.title,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                     widget.duration,
//                     style: TextStyle(
//                       color: Colors.grey.shade600,
//                     ),
//                   ),
//                   trailing: const Icon(
//                     Icons.close,
//                     color: Colors.grey,
//                   ),
//                   onTap: () {
//                     Get.back();
//                   },
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // Add to Basket Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     backgroundColor: Colors.purple,
//                     foregroundColor: Colors.white,
//                     textStyle: const TextStyle(fontSize: 16),
//                   ),
//                   onPressed: () async {
//                     // Format date string as dd-MM-yyyy
//                     final selectedDateObj = DateTime.now().add(
//                       Duration(days: controller.selectedDate.value),
//                     );
//                     final dateString =
//                         DateFormat('dd-MM-yyyy').format(selectedDateObj);

//                     // Create basket model with SubService data
//                     BasketDataModel basket = BasketDataModel(
//                       userId: UserSession.userModel.value.id,
//                       adminId: widget.subService.adminId,
//                       clientName: UserSession.userModel.value.name.toString(),
//                       date: dateString,
//                       services: [widget.subService.id],
//                       stylist: widget.selectedEmployee?.id ?? "",
//                       timeSlot: controller.selectedTime.value,
//                       price: widget.subService.price.toString(),
//                       createdByModel: "Admin",
//                       createdBy: widget.subService.adminId,
//                     );

//                     // Submit basket data
//                     controller.submitBusinessProfile(
//                       busket: basket,
//                     );
//                   },
//                   child: const Text("Add in Basket"),
//                 ),
//               ),

//               const SizedBox(height: 10),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }


import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:beauty/models/sub_services_salon_model.dart';
import 'package:beauty/models/busket_data_model.dart';
import 'package:beauty/service/user_session/user_session.dart';
import 'package:beauty/controllers/search_and_book_services_controllers/choose_date_and_time_controller/choose_date_and_time_controller.dart';

class ChooseDateTimeScreen extends StatefulWidget {
  final SubService subService;
  final AssignedEmployee? selectedEmployee;
  final String duration;

  const ChooseDateTimeScreen({
    Key? key,
    required this.subService,
    this.selectedEmployee,
    required this.duration,
  }) : super(key: key);

  @override
  State<ChooseDateTimeScreen> createState() => _ChooseDateTimeScreenState();
}

class _ChooseDateTimeScreenState extends State<ChooseDateTimeScreen> {
  final controller = Get.put(ChooseDateTimeController());

  @override
  void initState() {
    super.initState();
    controller.fetchEmployees(widget.subService.adminId);
    log("SubService Title: ${widget.subService.title}");
    log("Admin ID: ${widget.subService.adminId}");
    log("SubService Image List: ${widget.subService.subServiceImage}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text("Choose Date & Time"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.purple,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Obx(
                    () => Text(
                      controller.currentMonth.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_left, color: Colors.white),
                        onPressed: () => controller.previousMonth(),
                      ),
                      Expanded(
                        child: Obx(
                          () => SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(controller.dates.length, (index) {
                                var date = controller.dates[index];
                                bool isSelected = index == controller.selectedDate.value;
                                return GestureDetector(
                                  onTap: () async {
                                    controller.selectDate(index);
                                    TimeOfDay? pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (pickedTime != null) {
                                      controller.selectedTime.value = pickedTime.format(Get.context!);
                                      showBottomSheetView(Get.context!);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Column(
                                      children: [
                                        Text(
                                          date["day"]!,
                                          style: TextStyle(
                                            color: isSelected ? Colors.white : Colors.white70,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          date["weekDay"]!,
                                          style: TextStyle(
                                            color: isSelected ? Colors.white : Colors.white60,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_right, color: Colors.white),
                        onPressed: () => controller.nextMonth(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildServiceDetailsCard(),
            ),
            const SizedBox(height: 20),
            if (widget.selectedEmployee != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildStylistInfoCard(),
              ),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.selectedDate.value != -1 && controller.selectedTime.value.isEmpty) {
                return _buildTimeSlotGrid();
              }
              return const SizedBox.shrink();
            }),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: controller.selectedTime.value.isEmpty
                      ? null
                      : () {
                          showBottomSheetView(context);
                        },
                  child: const Text(
                    "Confirm Selection",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceDetailsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Service Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                if (widget.subService.subServiceImage.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "https://appsdemo.pro/Framie/${widget.subService.subServiceImage.first}",
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 70,
                        height: 70,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 25),
                      ),
                    ),
                  )
                else
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.image_not_supported, size: 25),
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.subService.title,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.duration,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "\$${widget.subService.price.toStringAsFixed(2)}",
                        style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStylistInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Selected Stylist",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    "https://appsdemo.pro/Framie/${widget.selectedEmployee!.employeeImage}",
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 70,
                      height: 70,
                      color: Colors.grey[300],
                      child: const Icon(Icons.person, size: 25),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.selectedEmployee!.employeeName,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.selectedEmployee!.about,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlotGrid() {
    final List<String> timeSlots = [
      '9:00 AM',
      '10:00 AM',
      '11:00 AM',
      '12:00 PM',
      '1:00 PM',
      '2:00 PM',
      '3:00 PM',
      '4:00 PM',
      '5:00 PM',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select Time",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: timeSlots.map((time) {
              return GestureDetector(
                onTap: () {
                  controller.selectedTime.value = time;
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width - 52) / 3,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(time, style: const TextStyle(fontSize: 14)),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void showBottomSheetView(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 35, left: 16, right: 16, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Your Basket",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: widget.subService.subServiceImage.isNotEmpty
                        ? Image.network(
                            "https://appsdemo.pro/Framie/${widget.subService.subServiceImage.first}",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 50,
                              height: 50,
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported, size: 20),
                            ),
                          )
                        : Container(
                            width: 50,
                            height: 50,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported, size: 20),
                          ),
                  ),
                  title: Text(
                                 widget.subService.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    widget.duration,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  trailing: const Icon(Icons.close, color: Colors.grey),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () async {
                    // Validate inputs
                    if (controller.selectedTime.value.isEmpty) {
                      Get.snackbar('Error', 'Please select a time slot');
                      return;
                    }

                    // Format date string as dd-MM-yyyy
                    final selectedDateObj = DateTime.now().add(Duration(days: controller.selectedDate.value));
                    final dateString = DateFormat('dd-MM-yyyy').format(selectedDateObj);

                    // Create basket model with SubService data
                    BasketDataModel basket = BasketDataModel(
                      userId: UserSession.userModel.value.id,
                      adminId: widget.subService.adminId,
                      clientName: UserSession.userModel.value.name.toString(),
                      date: dateString,
                      services: [widget.subService.id],
                      stylist: widget.selectedEmployee?.id, // Send null if no stylist selected
                      timeSlot: controller.selectedTime.value,
                      price: widget.subService.price.toString(),
                      createdByModel: "Admin",
                      createdBy: widget.subService.adminId,
                    );

                    // Submit basket data
                    controller.submitBusinessProfile(busket: basket);
                  },
                  child: const Text("Add in Basket"),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}