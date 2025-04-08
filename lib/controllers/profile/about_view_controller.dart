import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppController extends GetxController {
  void openPrivacyPolicy() {}

  void openTermsConditions() {}

  void openLicenses() {}

  Future<void> rateApp() async {
    final Uri url = Uri.parse(
        'https://play.google.com/store/apps/details?id=com.venturevilla.beauty');
    if (!await launchUrl(url)) {
      Get.snackbar(
        'Error',
        'Could not open app store',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> shareApp() async {}

  Future<void> openSocialMedia(String platform) async {
    Uri? url;

    switch (platform) {
      case 'facebook':
        url = Uri.parse('https://facebook.com/');
        break;
      case 'instagram':
        url = Uri.parse('https://instagram.com/');
        break;
      case 'twitter':
        url = Uri.parse('https://twitter.com/');
        break;
      case 'linkedin':
        url = Uri.parse('https://linkedin.com/company/');
        break;
    }

    if (url != null && !await launchUrl(url)) {
      Get.snackbar(
        'Error',
        'Could not open $platform',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
