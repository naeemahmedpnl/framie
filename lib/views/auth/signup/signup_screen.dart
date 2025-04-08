import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/auth_controller/signupScreenController/signup_screen_controller.dart';
import '/utils/widgets/custom_appbar.dart';
import '/utils/widgets/custom_button.dart';
import '/utils/widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Sign Up'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Continue To Sign Up',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Color(0xff51004F),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please confirm your name and mobile number',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 32),
            UnderlinedTextField(
              prefix: 'First Name',
              hint: 'Enter your first name',
              controller: controller.firstNameController,
            ),
            const SizedBox(height: 20),
            UnderlinedTextField(
              prefix: 'Last Name',
              hint: 'Enter your last name',
              controller: controller.lastNameController,
            ),
            const SizedBox(height: 20),
            UnderlinedTextField(
              prefix: 'Email',
              hint: 'Enter your Email',
              controller: controller.emailController,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                CountryCodePicker(
                  onChanged: (CountryCode countryCode) {
                    controller.updateCountryCode(countryCode.dialCode ?? '+1');
                  },
                  initialSelection: 'CA',
                  showCountryOnly: false,
                  showFlag: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: UnderlinedTextField(
                    hint: 'Mobile Number',
                    controller: controller.mobileController,
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            UnderlinedTextField(
              prefix: 'Choose City',
              hint: 'Select a city',
              controller: controller.cityController,
              showTrailingDropdown: true,
              onTap: controller.showCityPicker,
            ),
            const SizedBox(height: 20),
            UnderlinedTextField(
              prefix: 'Password',
              hint: 'Enter your password',
              controller: controller.passwordController,
            ),
            const SizedBox(height: 40),
            Obx(
              () => CustomButton(
                text: "Continue",
                isLoading: controller.isLoading.value,
                onPressed: () {
                  controller.registerUser();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
