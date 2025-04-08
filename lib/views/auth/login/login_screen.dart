import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/auth_controller/loginScreenController/login_screen_controller.dart';
import '/utils/widgets/custom_appbar.dart';
import '/utils/widgets/custom_textfield.dart';
import '../../../utils/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'login'.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'continueLogin'.tr,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff51004F),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'enterDetails'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 24),
                UnderlinedTextField(
                  prefix: 'username'.tr,
                  hint: 'enterUsername'.tr,
                  controller: controller.usernameController,
                ),
                const SizedBox(height: 16),
                UnderlinedTextField(
                  prefix: 'password'.tr,
                  hint: "Enter your Password",
                  controller: controller.passwordController,
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    'loginWith'.tr,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 16),
                _buildSocialButton(
                  icon: "assets/images/google_icon.png",
                  text: 'signWithGoogle'.tr,
                  backgroundColor: Colors.white,
                  borderColor: Colors.black12,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 12),
                _buildSocialButton(
                  icon: "assets/images/apple_icon.png",
                  text: 'signWithApple'.tr,
                  backgroundColor: Colors.black,
                  borderColor: Colors.black,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 12),
                _buildSocialButton(
                  icon: "assets/images/facebook_icon.png",
                  text: 'signWithFacebook'.tr,
                  backgroundColor: Colors.white,
                  borderColor: Colors.black12,
                  textColor: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Obx(
                () => CustomButton(
                  text: 'continue'.tr,
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    // Get.offAllNamed(kNavigationMenuViewRoute);
                    controller.login();
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
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
