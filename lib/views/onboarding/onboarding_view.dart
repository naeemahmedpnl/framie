import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/view_consants.dart';
import '../admin_auth/auth_signup/auth_signup_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      image: 'assets/images/onboarding.png',
      title: 'onboardingTitle1'.tr,
      description: 'onboardingDescription1'.tr,
      buttonText: 'skip'.tr,
    ),
    OnboardingContent(
      image: 'assets/images/onboarding1.png',
      title: 'onboardingTitle2'.tr,
      description: 'onboardingDescription2'.tr,
      buttonText: 'skip'.tr,
    ),
    OnboardingContent(
      image: 'assets/images/onboarding2.png',
      title: 'onboardingTitle3'.tr,
      description: 'onboardingDescription3'.tr,
      buttonText: 'signup'.tr,
      showLogin: true,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _contents.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(
                content: _contents[index],
                isLastPage: index == _contents.length - 1,
                onSkip: () {
                  if (index == _contents.length - 1) {
                    // Navigate to sign up page
                    _navigateToSignUp();
                  } else {
                    // Skip to last page
                    _pageController.animateToPage(
                      _contents.length - 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                onLogin:
                    index == _contents.length - 1 ? _navigateToLogin : null,
              );
            },
          ),
          Positioned(
            bottom: 35,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Hide dots when on last page
                if (_currentPage != _contents.length - 1)
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Row(
                      children: List.generate(
                        _contents.length,
                        (index) => _buildDot(index),
                      ),
                    ),
                  ),
                // Hide skip button when on last page
                if (_currentPage != _contents.length - 1)
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _pageController.animateToPage(
                          _contents.length - 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index
            ? Colors.white
            : Colors.white.withValues(alpha: 0.5),
      ),
    );
  }

  void _navigateToSignUp() {
    log('Navigate to sign up');
    Get.toNamed(kSignUpViewRoute);
  }

  void _navigateToLogin() {
    log('Navigate to login');
    Get.toNamed(kLoginViewRoute);
  }
}

class OnboardingContent {
  final String image;
  final String title;
  final String description;
  final String buttonText;
  final bool showLogin;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    this.showLogin = false,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingContent content;
  final bool isLastPage;
  final VoidCallback onSkip;
  final VoidCallback? onLogin;

  const OnboardingPage({
    super.key,
    required this.content,
    required this.isLastPage,
    required this.onSkip,
    this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(content.image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.purple.withValues(alpha: 0.7),
            BlendMode.srcOver,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Spacer(flex: 3),
              Text(
                content.title,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                content.description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              const Spacer(flex: 5),
              if (isLastPage)
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF9C27B0), Color(0xFFEE82EE)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              spreadRadius: 0,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: onLogin,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.transparent,
                            minimumSize: const Size(0, 48),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Text(
                            'login'.tr,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onSkip,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.purple,
                          minimumSize: const Size(0, 48),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text(
                          content.buttonText,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              if (isLastPage)
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'salonOwner'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => AuthSignUpScreen());
                        },
                        child: Text(
                          'register'.tr,
                          style: TextStyle(
                            color: Colors.white,
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
