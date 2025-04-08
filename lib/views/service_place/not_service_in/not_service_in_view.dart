import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/views/nav_menu/navigation_menu.dart';
import '../../../controllers/services_place_controllers/not_in_service_area_controller/not_service_area_controller.dart';
import '../../../utils/widgets/custom_button.dart';

class NotServiceInView extends StatelessWidget {
  const NotServiceInView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotInServiceViewController());
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text('Still Working On Your Location!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            )),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Map Container with Information Overlay
            SizedBox(
              height: screenWidth * 0.8,
              width: double.infinity,
              child: ClipRRect(
                child: Stack(
                  children: [
                    // Map Background
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://maps.googleapis.com/maps/api/staticmap?center=40.7128,-74.0060&zoom=14&size=600x600&markers=color:red%7C40.7128,-74.0060&key=AIzaSyD6fce90tdhc2Vms4O-8JqwvF7feJrYE3I',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),

                    // Location Pin
                    Center(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 32,
                      ),
                    ),

                    // Bottom Overlay
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        color: Colors.purple.shade700,
                        child: Obx(() => Text(
                              controller.expansionMessage.value,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Help Container
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question Icon
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xff51004F),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.question_mark,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),

                  SizedBox(height: 12),

                  // Question Text
                  Text(
                    'Do you think something is wrong?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF4A0072),
                    ),
                  ),

                  SizedBox(height: 12),

                  // Description Text
                  Text(
                    'You can send your query to our customer service representative.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                  ),

                  SizedBox(height: 70),

                  // Support Button

                  CustomButton(
                    text: 'Support',
                    onPressed: () {
                      Get.to(() => NavigationMenu());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SupportButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const SupportButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          colors: onPressed == null
              ? [Colors.grey.shade300, Colors.grey.shade400]
              : [Colors.purple.shade300, Colors.purple.shade600],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: onPressed == null
            ? []
            : [
                BoxShadow(
                  color: Colors.purple.shade200.withValues(alpha: 0.5),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(25),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Support',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
