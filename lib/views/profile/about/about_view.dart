import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/profile/about_view_controller.dart';
import '../license/license_view.dart';
import '../privacy/privacy_policy_view.dart';
import '../rate/rate_view.dart';
import '../terms_and_conditions/terms_and_condition_view.dart';
import 'about_app_view.dart';

class AboutAppView extends StatelessWidget {
  const AboutAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AboutAppController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'About App',
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
              _buildListItem(
                icon: Icons.info_rounded,
                iconColor: Colors.purple,
                title: 'About App',
                onTap: () {
                  Get.to(() => AboutAppScreen());
                },
              ),
              const Divider(),
              _buildListItem(
                icon: Icons.description,
                iconColor: Colors.purple,
                title: 'Privacy Policy',
                onTap: () {
                  Get.to(() => PrivacyPolicyScreen());
                },
              ),
              const Divider(),
              _buildListItem(
                icon: Icons.format_list_bulleted,
                iconColor: Colors.purple,
                title: 'Terms & Conditions',
                onTap: () {
                  Get.to(() => TermsAndConditionsScreen());
                },
              ),
              const Divider(),
              _buildListItem(
                icon: Icons.card_membership,
                iconColor: Colors.purple,
                title: 'Licenses',
                onTap: () {
                  Get.to(() => LicenseView());
                },
              ),
              const Divider(),
              _buildListItem(
                icon: Icons.play_arrow,
                iconColor: Colors.purple,
                title: 'Rate us on Play Store',
                onTap: () {
                  Get.to(() => RateAppScreen());
                },
              ),
              const Divider(),
              _buildListItem(
                icon: Icons.share,
                iconColor: Colors.purple,
                title: 'Share App',
                onTap: controller.shareApp,
              ),
              const Divider(),
              const SizedBox(height: 30),
              _buildSectionHeader('Follow Us On'),
              const SizedBox(height: 10),
              _buildSocialMediaItem(
                image: 'assets/icons/fb.png',
                title: 'Facebook',
                onTap: () => controller.openSocialMedia('facebook'),
              ),
              const Divider(),
              _buildSocialMediaItem(
                image: 'assets/icons/insta.png',
                title: 'Instagram',
                onTap: () => controller.openSocialMedia('instagram'),
              ),
              const Divider(),
              _buildSocialMediaItem(
                image: 'assets/icons/twitter.png',
                title: 'Twitter',
                onTap: () => controller.openSocialMedia('twitter'),
              ),
              const Divider(),
              _buildSocialMediaItem(
                image: 'assets/icons/linkedin.png',
                title: 'Linkedin',
                onTap: () => controller.openSocialMedia('linkedin'),
              ),
              const Divider(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialMediaItem({
    required String image,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          children: [
            Image.asset(image),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}
