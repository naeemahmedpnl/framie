import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/profile/edit_address_view_controller.dart';

class EditAddressView extends StatelessWidget {
  const EditAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditAddressController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Edit Address',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildSectionHeader('Address Details'),
              const SizedBox(height: 16),
              _buildTextField(
                controller: controller.streetFlatController,
                hint: 'Street & Flat No',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: controller.streetController,
                hint: 'Street',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: controller.postcodeController,
                hint: 'Postcode',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: controller.cityController,
                hint: 'City',
              ),
              const SizedBox(height: 30),
              _buildSectionHeader('Address Type'),
              const SizedBox(height: 16),
              _buildAddressTypeSelector(),
              const SizedBox(height: 30),
              _buildSectionHeader('Additional Information'),
              const SizedBox(height: 16),
              _buildStairsDropdown(),
              const SizedBox(height: 16),
              _buildSwitchOption(
                'I have cat(s)',
                controller.hasCat,
                (value) => controller.hasCat.value = value,
              ),
              const SizedBox(height: 16),
              _buildSwitchOption(
                'I have dog(s)',
                controller.hasDog,
                (value) => controller.hasDog.value = value,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: controller.parkingInfoController,
                hint: 'Parking Information and any other directions?',
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: controller.additionalInfoController,
                hint: 'Anything else you want to mention?',
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              _buildRemoveButton(),
              const SizedBox(height: 24),
              _buildSaveButton(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        isDense: true,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
        ),
      ),
    );
  }

  Widget _buildAddressTypeSelector() {
    final controller = Get.put(EditAddressController());

    return Obx(() => Column(
          children: [
            RadioListTile<String>(
              title: Row(
                children: [
                  Icon(Icons.home, color: Colors.purple.shade400),
                  const SizedBox(width: 12),
                  const Text('Home'),
                ],
              ),
              value: 'Home',
              groupValue: controller.addressType.value,
              onChanged: (value) => controller.changeAddressType(value!),
              activeColor: Colors.purple,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.trailing,
            ),
            const Divider(height: 1),
            RadioListTile<String>(
              title: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.purple.shade400),
                  const SizedBox(width: 12),
                  const Text('Custom Address'),
                ],
              ),
              value: 'Custom Address',
              groupValue: controller.addressType.value,
              onChanged: (value) => controller.changeAddressType(value!),
              activeColor: Colors.purple,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.trailing,
            ),
            const Divider(height: 1),
          ],
        ));
  }

  Widget _buildStairsDropdown() {
    final controller = Get.put(EditAddressController());

    return Row(
      children: [
        const SizedBox(width: 4),
        const Expanded(
          flex: 2,
          child: Text(
            'Do you have any stairs?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 3,
          child: Obx(() => DropdownButtonFormField<String>(
                value: controller.hasStairs.value,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  border: UnderlineInputBorder(),
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                items: controller.stairsOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: controller.setHasStairs,
              )),
        ),
      ],
    );
  }

  Widget _buildSwitchOption(
    String title,
    RxBool value,
    Function(bool) onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
        Obx(() => Switch(
              value: value.value,
              onChanged: onChanged,
              activeColor: Colors.purple,
            )),
      ],
    );
  }

  Widget _buildRemoveButton() {
    final controller = Get.put(EditAddressController());

    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: controller.removeAddress,
          child: Center(
            child: Text(
              'Remove Address',
              style: TextStyle(
                color: Colors.purple.shade600,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    final controller = Get.put(EditAddressController());

    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          colors: [
            Colors.purple.shade700,
            Colors.purple.shade300,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: controller.saveChanges,
          child: const Center(
            child: Text(
              'Save Changes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
