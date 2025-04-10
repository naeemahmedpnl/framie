import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/auth_controller/otpScreenController/otp_verification_controller.dart';
import '/utils/widgets/custom_appbar.dart';
import '/utils/widgets/custom_button.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;
  final String userId;
  final String otp;
  const OTPVerificationScreen(
      {super.key,
      required this.otp,
      required this.email,
      required this.userId});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final controller = Get.put(OTPVerificationController());

  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onDigitEntered(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 5) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else {
        focusNodes[index].unfocus();
      }
    }
  }

  void _onBackspace(String value, int index) {
    if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }
  }

  void _clearAllFields() {
    for (var controller in controller.otpControllers) {
      controller.clear();
    }
    FocusScope.of(context).requestFocus(focusNodes[0]);
  }

  @override
  Widget build(BuildContext context) {
    log(widget.otp.toString());

    return Scaffold(
      appBar: CustomAppBar(title: 'OTP Verification'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Please enter the 6-digit code sent to your\nemail address",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 40,
                    child: TextField(
                      controller: controller.otpControllers[index],
                      focusNode: focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: const InputDecoration(
                        counterText: '',
                        border: UnderlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _onDigitEntered(value, index);
                        _onBackspace(value, index);
                      },
                      onSubmitted: (_) {
                        if (index == 5) {
                          controller.verifyOTP(widget.email);
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  _clearAllFields();
                  controller.resendOTP(userId: widget.userId);
                },
                child: const Text(
                  "Resend the code",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              const Spacer(),
              Obx(
                () => CustomButton(
                  text: "Verify",
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.verifyOTP(widget.email);
                  },
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
