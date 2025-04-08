import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/services_place_controllers/service_in_view_controller/service_in_view_controller.dart';
import '../../../utils/widgets/custom_button.dart';
import '../not_service_in/not_service_in_view.dart';

class ServiceInView extends StatelessWidget {
  const ServiceInView({super.key});

  @override
  Widget build(BuildContext context) {
    final ServiceInViewController controller =
        Get.put(ServiceInViewController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Confirm Address',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Map View
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                child: Image.network(
                  'https://maps.googleapis.com/maps/api/staticmap?center=40.7128,-74.0060&zoom=14&size=600x300&markers=color:red%7C40.7128,-74.0060&key=AIzaSyD6fce90tdhc2Vms4O-8JqwvF7feJrYE3I',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade300,
                      child: Icon(
                        Icons.map,
                        size: 50,
                        color: Colors.grey.shade700,
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 24),

              // Address Details Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: 16),

                    // Street & Flat No
                    _buildTextField(
                      controller: controller.streetAndFlatController,
                      hint: 'House / Flat / Room Number',
                      label: 'Street & Flat No',
                    ),

                    SizedBox(height: 16),

                    // Street
                    _buildTextField(
                      controller: controller.streetController,
                      hint: '',
                      label: 'Street',
                    ),

                    SizedBox(height: 16),

                    // Postcode
                    _buildTextField(
                      controller: controller.postcodeController,
                      hint: '',
                      label: 'Postcode',
                    ),

                    SizedBox(height: 16),

                    // City
                    _buildTextField(
                      controller: controller.cityController,
                      hint: '',
                      label: 'City',
                    ),

                    SizedBox(height: 32),

                    // Address Type Section
                    Text(
                      'Address Type',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: 16),

                    // Home Option
                    _buildAddressTypeOption(
                      type: 'Home',
                      icon: Icons.home_outlined,
                    ),

                    Divider(
                        height: 1, thickness: 1, color: Colors.grey.shade200),

                    // Custom Address Option
                    _buildAddressTypeOption(
                      type: 'Custom Address',
                      icon: Icons.location_on_outlined,
                    ),

                    SizedBox(height: 32),

                    // Save Address Button
                    CustomButton(
                      text: 'Save Address',
                      onPressed: () {
                        Get.to(() => NotServiceInView());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.purple),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressTypeOption({
    required String type,
    required IconData icon,
  }) {
    return TextFormField(
      readOnly: true,
      initialValue: type,
      onTap: () {},
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.purple,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.purple,
          size: 20,
        ),
        border: InputBorder.none,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
      ),
    );
  }
}
