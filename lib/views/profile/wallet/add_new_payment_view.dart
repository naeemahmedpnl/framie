import '/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/profile/add_new_payment_view_controller.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentMethodController>(
      init: PaymentMethodController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              'New Payment Method',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () => Get.back(),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tab Bar
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFEEEEEE),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      _buildTab(
                        title: 'New Card',
                        isActive: controller.selectedTab.value == 0,
                        onTap: () => controller.changeTab(0),
                      ),
                      _buildTab(
                        title: 'Others',
                        isActive: controller.selectedTab.value == 1,
                        onTap: () => controller.changeTab(1),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                // Scan Card Button
                GestureDetector(
                  onTap: controller.scanCard,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Scan Your Card',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                // Card Form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card Number
                        TextFormField(
                          controller: controller.cardNumberController,
                          decoration: const InputDecoration(
                            labelText: 'Card No',
                            border: UnderlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: controller.validateCardNumber,
                        ),

                        const SizedBox(height: 20),
                        // Name on Card
                        TextFormField(
                          controller: controller.nameController,
                          decoration: const InputDecoration(
                            labelText: 'Enter your first name',
                            border: UnderlineInputBorder(),
                          ),
                          validator: controller.validateName,
                        ),

                        const SizedBox(height: 20),
                        // Expiry Date
                        Row(
                          children: [
                            const Text(
                              'Expire Date',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            // Month Dropdown
                            Container(
                              width: 100,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: Obx(() => DropdownButton<String>(
                                      value: controller.selectedMonth.value,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items:
                                          controller.months.map((String month) {
                                        return DropdownMenuItem<String>(
                                          value: month,
                                          child: Text(month),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        controller.selectedMonth.value =
                                            newValue!;
                                      },
                                      hint: const Text('MM'),
                                    )),
                              ),
                            ),
                            const SizedBox(width: 20),
                            // Year Dropdown
                            Container(
                              width: 100,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: Obx(() => DropdownButton<String>(
                                      value: controller.selectedYear.value,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items:
                                          controller.years.map((String year) {
                                        return DropdownMenuItem<String>(
                                          value: year,
                                          child: Text(year),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        controller.selectedYear.value =
                                            newValue!;
                                      },
                                      hint: const Text('YYYY'),
                                    )),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        // CVV/CV2
                        TextFormField(
                          controller: controller.cvvController,
                          decoration: const InputDecoration(
                            labelText: 'CVV/CV2',
                            border: UnderlineInputBorder(),
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          validator: controller.validateCVV,
                        ),

                        const SizedBox(height: 20),
                        // Country
                        Row(
                          children: [
                            const Text(
                              'Country',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.network(
                                    'https://flagcdn.com/w20/gb.png',
                                    width: 24,
                                    height: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'United Kingdom',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Icon(Icons.keyboard_arrow_down),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        // Postcode
                        TextFormField(
                          controller: controller.postcodeController,
                          decoration: const InputDecoration(
                            labelText: 'Postcode',
                            border: UnderlineInputBorder(),
                          ),
                          validator: controller.validatePostcode,
                        ),

                        const SizedBox(height: 60),
                        CustomButton(
                          text: 'Save Card',
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTab(
      {required String title,
      required bool isActive,
      required VoidCallback onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? const Color(0xFFAA2FB0) : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isActive ? const Color(0xFFAA2FB0) : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
