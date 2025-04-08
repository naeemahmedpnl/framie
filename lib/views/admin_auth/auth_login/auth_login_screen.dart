import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/admin_controllers/adminLoginScreenController/admin_login_screen_controller.dart';
import '/utils/widgets/custom_appbar.dart';
import '/utils/widgets/custom_button.dart';
import '/utils/widgets/custom_textfield.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final AdminLoginController controller = Get.put(AdminLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Login admin'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Continue To Login",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Color(0xff51004F),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Please Enter your details",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 24),
            UnderlinedTextField(
              prefix: "Username",
              hint: "Enter your Username",
              controller: controller.usernameController,
            ),
            const SizedBox(height: 16),
            UnderlinedTextField(
              prefix: "Password",
              hint: "Enter your Password",
              controller: controller.passwordController,
            ),
            const SizedBox(height: 24),
            Center(
              child: const Text(
                "Login with",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 16),
            _buildSocialButton(
              icon: "assets/images/google_icon.png",
              text: "Sign in with Google",
              backgroundColor: Colors.white,
              borderColor: Colors.black12,
              textColor: Colors.black,
            ),
            const SizedBox(height: 12),
            _buildSocialButton(
              icon: "assets/images/apple_icon.png",
              text: "Sign in with Apple",
              backgroundColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.white,
            ),
            const SizedBox(height: 12),
            _buildSocialButton(
              icon: "assets/images/facebook_icon.png",
              text: "Sign in with Facebook",
              backgroundColor: Colors.white,
              borderColor: Colors.black12,
              textColor: Colors.black,
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Obx(
                    () => CustomButton(
                      text: "Continue",
                      isLoading: controller.isLoading.value,
                      onPressed: () {
                        controller.adminLogin();
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Image.asset(
                  "assets/images/face_icon.png",
                  width: 40,
                  height: 40,
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String icon,
    required String text,
    required Color backgroundColor,
    required Color borderColor,
    required Color textColor,
  }) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, width: 24, height: 24),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
