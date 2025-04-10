import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/admin_controllers/adminSignupScreenController/admin_signup_screen_controller.dart';
import '/utils/widgets/custom_appbar.dart';
import '/utils/widgets/custom_button.dart';
import '/utils/widgets/custom_textfield.dart';
import '../auth_login/auth_login_screen.dart';

class AuthSignUpScreen extends StatefulWidget {
  const AuthSignUpScreen({super.key});

  @override
  State<AuthSignUpScreen> createState() => _AuthSignUpScreenState();
}

class _AuthSignUpScreenState extends State<AuthSignUpScreen> {
  final AuthSignUpController controller = Get.put(AuthSignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Create Profile'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **Title Section**
              Text(
                'Enter your details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xff51004F),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Please confirm your details',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
        
              /// **Profile Picture (Circular)**
              Row(
                children: [
                  Stack(
                    children: [
                      /// **Default Icon or Selected Image**
                      Obx(() => CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.grey.shade300,
                            child: controller.businessLogo.value == null
                                ? const Icon(Icons.person,
                                    size: 50, color: Colors.grey)
                                : ClipOval(
                                    child: Image.file(
                                      controller.businessLogo.value!,
                                      width: 90,
                                      height: 90,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          )),
        
                      /// **Camera Icon Button**
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => controller.showImageSourceMenu(context),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.purple,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
        
              /// **Form Fields**
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
                hint: 'Enter your email',
                controller: controller.emailController,
              ),
              const SizedBox(height: 20),
        
              /// **Phone Number Input**
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
        
              /// **City Selection**
              UnderlinedTextField(
                prefix: 'City',
                hint: 'Enter your city',
                controller: controller.cityController,
              ),
              const SizedBox(height: 20),
        
              /// **Password Input**
              UnderlinedTextField(
                prefix: 'Password',
                hint: 'Enter your password',
                controller: controller.passwordController,
              ),
              const SizedBox(height: 40),
        
              /// **Continue Button**
              Obx(
                () => CustomButton(
                  text: "Continue",
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.registerAdmin();
                  },
                ),
              ),
        
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an Account? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => AdminLoginScreen());
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
