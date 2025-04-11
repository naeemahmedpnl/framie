import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/views/search_and_book_services/basket_screen/basket_screen.dart';
import '../../../controllers/services_place_controllers/booking_view_controller/booking_view_controller.dart';
import '../../../models/appointment_model.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../search_and_book_services/booking_details_screen/booking_details_screen.dart';
import '../booking_receipt/booking_receipt_details_view.dart';


class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final controller = Get.put(BookingController());

  @override
  void initState() {
    super.initState();
    controller.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const Text(
          'Bookings',
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
                color: const Color(0xffA83F98),
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Row(
                children: [
                  const Text(
                    '0', // Update this to be dynamic if needed
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
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
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: controller.activeTab.value == 0
                                      ? const Color(0xFF8B1F8F)
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Upcoming',
                                style: TextStyle(
                                  color: controller.activeTab.value == 0
                                      ? const Color(0xFF8B1F8F)
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
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: controller.activeTab.value == 1
                                      ? const Color(0xFF8B1F8F)
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
                                      ? const Color(0xFF8B1F8F)
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
                () => controller.activeTab.value == 0
                    ? _buildUpcomingTab(controller)
                    : _buildPastTab(controller),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingTab(BookingController controller) {
    return Obx(() {
      if (controller.appointmentData.isEmpty) {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            // Empty state placeholders
            ...List.generate(
                6,
                (index) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.only(bottom: 16),
                      height: 80,
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 12,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 12,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 12,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'No appointments yet? Time to treat yourself!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff51004F),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Book Now',
                    onPressed: () {
                      Get.to(() => const UnifiedBookingScreen());
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }

      return ListView.builder(
        itemCount: controller.appointmentData.length,
        itemBuilder: (context, index) {
          final appointment = controller.appointmentData[index];
          return Dismissible(
            key: Key(appointment.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(
                size: 40,
                Icons.delete,
                color: Colors.white,
              ),
            ),
            confirmDismiss: (direction) async {
              return await _showDeleteConfirmationDialog(context);
            },
            onDismissed: (direction) {
              controller.deleteAppointment(appointment.id, true);
            },
            child: Container(
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
                              color: const Color(0xFF8B1F8F).withOpacity(0.1),
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
                                    onTap: () {},
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
                              color: const Color(0xFF8B1F8F).withOpacity(0.1),
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
                  const Divider(height: 1, color: Colors.grey),
                  const SizedBox(height: 16),

                  // Practitioner row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B1F8F).withOpacity(0.1),
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
                  const Divider(height: 1, color: Colors.grey),
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
                                color: const Color(0xFF8B1F8F).withOpacity(0.1),
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
                  const Divider(height: 1, color: Colors.grey),
                  const SizedBox(height: 16),

                  // Status, Delete, and Rebook button row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Status
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B1F8F).withOpacity(0.1),
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

                      // Delete and Rebook buttons
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 20,
                            ),
                            onPressed: () async {
                              final confirm = await _showDeleteConfirmationDialog(context);
                              if (confirm) {
                                controller.deleteAppointment(appointment.id, true);
                              }
                            },
                          ),
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
                    ],
                  ),

                  // View Details text
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          Get.to(() => BookingReceiptDetailsView(
                                appointmentData: appointment,
                              ));
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
          );
        },
      );
    });
  }

  Widget _buildPastTab(BookingController controller) {
    return Obx(() {
      if (controller.pastAppointments.isEmpty) {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            // Empty state placeholders
            ...List.generate(
                3,
                (index) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.only(bottom: 16),
                      height: 80,
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 12,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 12,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 12,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'No past appointments found.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff51004F),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Book Now',
                    onPressed: () {
                      Get.to(() => const UnifiedBookingScreen());
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }

      return ListView.builder(
        itemCount: controller.pastAppointments.length,
        itemBuilder: (context, index) {
          final appointment = controller.pastAppointments[index];
          return Dismissible(
            key: Key(appointment.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            confirmDismiss: (direction) async {
              return await _showDeleteConfirmationDialog(context);
            },
            onDismissed: (direction) {
              controller.deleteAppointment(appointment.id, false);
            },
            child: Container(
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
                              color: const Color(0xFF8B1F8F).withOpacity(0.1),
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
                                    onTap: () {},
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
                              color: const Color(0xFF8B1F8F).withOpacity(0.1),
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
                                '${DateFormat('dd-MMM-yyyy').format(DateTime.parse(appointment.date))} | ${DateFormat('h:mma').format(DateTime.parse(appointment.date))}',
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
                  const Divider(height: 1, color: Colors.grey),
                  const SizedBox(height: 16),

                  // Practitioner row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B1F8F).withOpacity(0.1),
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
                  const Divider(height: 1, color: Colors.grey),
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
                                color: const Color(0xFF8B1F8F).withOpacity(0.1),
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
                                  '\$${appointment.price.toStringAsFixed(0)}',
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
                  const Divider(height: 1, color: Colors.grey),
                  const SizedBox(height: 16),

                  // Status, Delete, and Rebook button row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Status
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B1F8F).withOpacity(0.1),
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

                      // Delete and Rebook buttons
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 20,
                            ),
                            onPressed: () async {
                              final confirm = await _showDeleteConfirmationDialog(context);
                              if (confirm) {
                                controller.deleteAppointment(appointment.id, false);
                              }
                            },
                          ),
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
                    ],
                  ),

                  // View Details text
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          Get.to(() => BookingReceiptDetailsView(
                                appointmentData: appointment,
                              ));
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
          );
        },
      );
    });
  }

  Future<bool> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Appointment'),
            content: const Text('Are you sure you want to delete this appointment?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}

// class BookingDetailsScreen extends StatefulWidget {
//   const BookingDetailsScreen({super.key});

//   @override
//   State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
// }

// class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
//   final controller = Get.put(BookingController());

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
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () => Get.back(),
//         ),
//         centerTitle: true,
//         title: Text(
//           'Bookings',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: [
//           GestureDetector(
//             onTap: () {
//               Get.to(() => BasketScreen());
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Color(0xffA83F98),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               margin: EdgeInsets.only(right: 5),
//               padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
//               child: Row(
//                 children: [
//                   Text(
//                     0.toString(),
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   Icon(
//                     Icons.shopping_cart,
//                     color: Colors.white,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: SafeArea(
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

//   Widget _buildUpcomingTab(BookingController controller) {
//     return Obx(() {
//       if (controller.appointmentData.isEmpty) {
//         return ListView(
//           padding: EdgeInsets.symmetric(vertical: 16),
//           children: [
//             // Empty state placeholders
//             ...List.generate(
//                 6,
//                 (index) => Container(
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       margin: EdgeInsets.only(bottom: 16),
//                       height: 80,
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 80,
//                             height: 80,
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade200,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   height: 12,
//                                   width: 120,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.shade200,
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Container(
//                                   height: 12,
//                                   width: 200,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.shade200,
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Container(
//                                   height: 12,
//                                   width: 150,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.shade200,
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     )),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: [
//                   SizedBox(height: 24),
//                   Text(
//                     'No appointments yet? Time to treat yourself!',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w900,
//                       color: Color(0xff51004F),
//                     ),
//                   ),
//                   SizedBox(height: 24),
//                   CustomButton(
//                     text: 'Book Now',
//                     onPressed: () {
//                       Get.to(() => UnifiedBookingScreen());
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       }

//       return ListView(
//         children: [
//           for (AppointmentData appointment in controller.appointmentData)
//             Container(
//               margin: EdgeInsets.symmetric(
//                 horizontal: 16,
//                 vertical: 10,
//               ),
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Color(0xFFF9F1FA),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 children: [
//                   // Booking ID row
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Color(0xFF8B1F8F).withOpacity(0.1),
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.check,
//                               color: Color(0xFF8B1F8F),
//                               size: 12,
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Booking ID',
//                                 style: TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     appointment.id.length > 5
//                                         ? '${appointment.id.substring(0, 5)}...'
//                                         : appointment.id,
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                   SizedBox(width: 10),
//                                   GestureDetector(
//                                     onTap: () {},
//                                     child: Icon(
//                                       Icons.copy,
//                                       size: 15,
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ],
//                       ),

//                       // Booking Date
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             padding: EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Color(0xFF8B1F8F).withOpacity(0.1),
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.calendar_today,
//                               color: Color(0xFF8B1F8F),
//                               size: 12,
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Booked On',
//                                 style: TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               Text(
//                                 appointment.date,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),

//                   // Divider
//                   Divider(height: 1, color: Colors.grey.shade300),
//                   SizedBox(height: 16),

//                   // Practitioner row
//                   Row(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: Color(0xFF8B1F8F).withOpacity(0.1),
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           Icons.person,
//                           color: Color(0xFF8B1F8F),
//                           size: 12,
//                         ),
//                       ),
//                       SizedBox(width: 12),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Practitioners',
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 12,
//                             ),
//                           ),
//                           Text(
//                             appointment.clientName,
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),

//                   // Divider
//                   Divider(height: 1, color: Colors.grey.shade300),
//                   SizedBox(height: 16),

//                   // Amount and Date side by side
//                   Row(
//                     children: [
//                       // Amount
//                       Expanded(
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 color: Color(0xFF8B1F8F).withOpacity(0.1),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(
//                                 Icons.attach_money,
//                                 color: Color(0xFF8B1F8F),
//                                 size: 12,
//                               ),
//                             ),
//                             SizedBox(width: 12),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Total Amount',
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 Text(
//                                   '\$${appointment.price}',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),

//                   // Divider
//                   Divider(height: 1, color: Colors.grey.shade300),
//                   SizedBox(height: 16),

//                   // Status and Rebook button row
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Status
//                       Row(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Color(0xFF8B1F8F).withOpacity(0.1),
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.info_outline,
//                               color: Color(0xFF8B1F8F),
//                               size: 12,
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Status',
//                                 style: TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               Text(
//                                 appointment.status,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),

//                       // Rebook button
//                       ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xFF8B1F8F),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 20,
//                             vertical: 8,
//                           ),
//                         ),
//                         child: Text(
//                           'Rebook',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   // View Details text
//                   Padding(
//                     padding: EdgeInsets.only(left: 5, top: 20),
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: TextButton(
//                         onPressed: () {
//                           Get.to(() => BookingReceiptDetailsView(
//                                 appointmentData: appointment,
//                               ));
//                         },
//                         style: TextButton.styleFrom(
//                           padding: EdgeInsets.zero,
//                           minimumSize: Size(0, 0),
//                           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                         ),
//                         child: Text(
//                           'View Details',
//                           style: TextStyle(
//                             color: Color(0xFF8B1F8F),
//                             fontSize: 12,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       );
//     });
//   }

//   Widget _buildPastTab(BookingController controller) {
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
//                             color: Color(0xFF8B1F8F).withOpacity(0.1),
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
//                             color: Color(0xFF8B1F8F).withOpacity(0.1),
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
//                         color: Color(0xFF8B1F8F).withOpacity(0.1),
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
//                               color: Color(0xFF8B1F8F).withOpacity(0.1),
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
//                             color: Color(0xFF8B1F8F).withOpacity(0.1),
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
