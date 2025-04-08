import '/controllers/services_view_controller/service_booking_details_controller/service_booking_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceBookingDetailsScreen extends StatefulWidget {
  const ServiceBookingDetailsScreen({super.key});

  @override
  State<ServiceBookingDetailsScreen> createState() =>
      _ServiceBookingDetailsScreenState();
}

class _ServiceBookingDetailsScreenState
    extends State<ServiceBookingDetailsScreen> {
  final ServiceBookingDetailsController controller =
      Get.put(ServiceBookingDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // **Header Image**
          Stack(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20)),
                  image: DecorationImage(
                    image: AssetImage("assets/images/booking_screen.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 15,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () => Get.back(),
                  ),
                ),
              ),
            ],
          ),

          // **Service Booking Details**
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // **Service Name & Price in Same Row**
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        controller.serviceName.value,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        controller.servicePrice.value,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                Obx(() => Text(
                      controller.serviceDescription.value,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    )),
                SizedBox(height: 15),

                // **Time Row**
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.grey, size: 18),
                    SizedBox(width: 5),
                    Obx(
                      () => Text(
                        controller.serviceTime.value,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),
                // **Category Badge**
                Obx(() => Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            colors: [Colors.purple, Colors.pink]),
                      ),
                      child: Text(
                        controller.serviceCategory.value,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
          ),

          Spacer(),

          // **Edit Button**
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Center(
                child: Text(
                  "Edit Now",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
