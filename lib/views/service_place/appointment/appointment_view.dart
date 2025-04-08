import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/services_place_controllers/appointment_view_controller/appointment_view_controller.dart';
import '../service_in/service_in_view.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppointmentController controller = Get.put(AppointmentController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                "Where's your next appointment?",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF4A0072),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Share your location, and we'll handle the rest!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 24),

              // Location input
              TextField(
                controller: controller.locationController,
                decoration: InputDecoration(
                  hintText: "Enter city or zipcode",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Use current location toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on_outlined, color: Colors.purple),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      controller.toggleCurrentLocation(
                        !controller.useCurrentLocation.value,
                      );
                    },
                    child: Text(
                      "Use my current location",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Distance slider
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Slider(
                        value: controller.radiusValue.value,
                        min: 1,
                        max: 3,
                        divisions: 2,
                        activeColor: Colors.purple,
                        inactiveColor: Colors.grey[300],
                        onChanged: controller.updateRadius,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "1 miles",
                              style: TextStyle(
                                color: controller.radiusValue.value == 1
                                    ? Colors.purple
                                    : Colors.grey,
                              ),
                            ),
                            Text(
                              "5 miles",
                              style: TextStyle(
                                color: controller.radiusValue.value == 2
                                    ? Colors.purple
                                    : Colors.grey,
                              ),
                            ),
                            Text(
                              "10 miles",
                              style: TextStyle(
                                color: controller.radiusValue.value == 3
                                    ? Colors.purple
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 32),

              Row(
                children: [
                  Obx(
                    () => Switch.adaptive(
                      value: controller.enableHomeServices.value,
                      onChanged: controller.toggleHomeServices,
                      activeColor: Colors.purple,
                      activeTrackColor: Colors.purple.withValues(alpha: .5),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Enable home services",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),

              Spacer(),

              // Skip button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => ServiceInView());
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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
}
