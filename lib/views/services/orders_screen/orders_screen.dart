import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/controllers/services_view_controller/orders_controller/orders_controller.dart';
import '/views/search_and_book_services/basket_screen/basket_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrdersController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          'Orders',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => BasketScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffA83F98),
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(right: 5),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Row(
                children: [
                  Text(
                    0.toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab bar
          Obx(() => Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.setActiveTab(0),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: controller.activeTab.value == 0
                                    ? Color(0xFF8B1F8F)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'New',
                              style: TextStyle(
                                color: controller.activeTab.value == 0
                                    ? Color(0xFF8B1F8F)
                                    : Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.setActiveTab(1),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: controller.activeTab.value == 1
                                    ? Color(0xFF8B1F8F)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Past',
                              style: TextStyle(
                                color: controller.activeTab.value == 1
                                    ? Color(0xFF8B1F8F)
                                    : Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),

          // Tab content
          Expanded(
            child: Obx(
              () => controller.activeTab.value != 0
                  ? Container()
                  : _buildPastTab(controller),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildUpcomingTab() {
  //   return Center(
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 20),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           // Empty state placeholders (similar to the screenshot)
  //           Expanded(
  //             child: ListView.builder(
  //               itemCount: 6,
  //               padding: EdgeInsets.symmetric(vertical: 16),
  //               itemBuilder: (context, index) {
  //                 return Container(
  //                   margin: EdgeInsets.only(bottom: 16),
  //                   height: 80,
  //                   child: Row(
  //                     children: [
  //                       Container(
  //                         width: 80,
  //                         height: 80,
  //                         decoration: BoxDecoration(
  //                           color: Colors.grey.shade200,
  //                           borderRadius: BorderRadius.circular(8),
  //                         ),
  //                       ),
  //                       SizedBox(width: 12),
  //                       Expanded(
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             Container(
  //                               height: 12,
  //                               width: 120,
  //                               decoration: BoxDecoration(
  //                                 color: Colors.grey.shade200,
  //                                 borderRadius: BorderRadius.circular(4),
  //                               ),
  //                             ),
  //                             SizedBox(height: 8),
  //                             Container(
  //                               height: 12,
  //                               width: 200,
  //                               decoration: BoxDecoration(
  //                                 color: Colors.grey.shade200,
  //                                 borderRadius: BorderRadius.circular(4),
  //                               ),
  //                             ),
  //                             SizedBox(height: 8),
  //                             Container(
  //                               height: 12,
  //                               width: 150,
  //                               decoration: BoxDecoration(
  //                                 color: Colors.grey.shade200,
  //                                 borderRadius: BorderRadius.circular(4),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //           SizedBox(height: 24),

  //           Text(
  //             'No appointments yet? Time to treat yourself!',
  //             textAlign: TextAlign.center,
  //             style: GoogleFonts.openSans(
  //               fontSize: 20,
  //               fontWeight: FontWeight.w900,
  //               color: Color(0xff51004F),
  //             ),
  //           ),
  //           SizedBox(height: 24),
  //           CustomButton(
  //             text: 'Book Now',
  //             onPressed: () {
  //               Get.to(() => UnifiedBookingScreen());
  //             },
  //           ),

  //           SizedBox(height: 24),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildPastTab(OrdersController controller) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          // Booking details card
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFFF9F1FA),
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
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFF8B1F8F).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Color(0xFF8B1F8F),
                            size: 12,
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Booking ID',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              controller.bookingsData.value.id,
                              style: TextStyle(
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
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFF8B1F8F).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.calendar_today,
                            color: Color(0xFF8B1F8F),
                            size: 12,
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Booked On',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '${DateFormat('dd-MMM-yyyy').format(controller.bookingsData.value.bookingDate)}|${DateFormat('h:mma').format(controller.bookingsData.value.bookingDate)}',
                              style: TextStyle(
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
                SizedBox(height: 16),

                // Divider
                Divider(height: 1, color: Colors.grey.shade300),
                SizedBox(height: 16),

                // Practitioner row
                Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFF8B1F8F).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
                            color: Color(0xFF8B1F8F),
                            size: 12,
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Practitioners',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              controller.bookingsData.value.practitionerName,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 12),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFF8B1F8F).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.info_outline,
                            color: Color(0xFF8B1F8F),
                            size: 12,
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Status',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              controller.bookingsData.value.status,
                              style: TextStyle(
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

                SizedBox(height: 16),

                // Divider
                Divider(height: 1, color: Colors.grey.shade300),
                SizedBox(height: 16),

                // Amount and Date side by side
                Row(
                  children: [
                    // Amount
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFF8B1F8F).withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.attach_money,
                              color: Color(0xFF8B1F8F),
                              size: 12,
                            ),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Amount',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '\$${controller.bookingsData.value.amount.toStringAsFixed(0)}',
                                style: TextStyle(
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
                SizedBox(height: 16),

                // Divider
                Divider(height: 1, color: Colors.grey.shade300),
                SizedBox(height: 16),

                // View Details text
                Padding(
                  padding: EdgeInsets.only(left: 5, top: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        // Get.to(() => BookingReceiptDetailsView(
                        //   appointmentData: ,
                        // ));
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
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
      ),
    );
  }
}
