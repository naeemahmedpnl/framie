import 'dart:developer';

import 'package:beauty/service/auth_service.dart';
import 'package:beauty/service/network_manager.dart';
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

  final GoogleSignInController _authService = GoogleSignInController();
  bool _isLoading = false;

Future<void> _handleGoogleSignIn() async {
  // Define a local function to handle sign out
  Future<void> signOut() async {
    log('Signing out from Google');
    try {
      await _authService.signOut();
      log('Successfully signed out from Google');
    } catch (e) {
      log('Error during sign out: $e');
      // Continue with sign-in process even if sign-out fails
    }
  }

  try {
    // First check network connectivity
    if (!await NetworkManager().isConnected()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please connect to the internet')),
      );
      return;
    }

    log('Checking if user is already signed in');
    final isSignedIn = await _authService.isSignedIn();
    if (isSignedIn) {
      log('User is already signed in, signing out');
      await signOut();
    }

    log('Starting Google Sign-In process');
    setState(() {
      _isLoading = true;
      log('Set loading state to true');
    });

    log('Calling Google Sign-In handler');
    await _authService.handleGoogleSignIn();
    

  } catch (e) {
    log('Error during Google Sign-In: $e');
    log('Stack trace: ${StackTrace.current}');

    // Show a more user-friendly error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sign in failed. Please try again later.'),
        backgroundColor: Colors.red,
      ),
    );
  } finally {
    log('Sign-in process completed, resetting loading state');
    if (mounted) {  // Check if the widget is still in the tree
      setState(() {
        _isLoading = false;
      });
    }
  }
}
  
  
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
              isLoading: _isLoading,
               onPressed: _handleGoogleSignIn,
              icon: "assets/images/google_icon.png",
              text: "Sign in with Google",
              backgroundColor: Colors.white,
              borderColor: Colors.black12,
              textColor: Colors.black,
            ),
            const SizedBox(height: 12),
            _buildSocialButton(
              isLoading: false,
               onPressed: (){},
              icon: "assets/images/apple_icon.png",
              text: "Sign in with Apple",
              backgroundColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.white,
            ),
            const SizedBox(height: 12),
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
  required bool isLoading,
  required VoidCallback onPressed,
  required String icon,
  required String text,
  required Color backgroundColor,
  required Color borderColor,
  required Color textColor,
}) {
  return GestureDetector( 
    onTap: isLoading ? null : onPressed,
    child: Container(
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
          if (isLoading)
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(textColor),
              ),
            )
          else
            Image.asset(icon, width: 24, height: 24),
          const SizedBox(width: 10),
          Text(
            isLoading ? "Loading..." : text,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}

 
}
