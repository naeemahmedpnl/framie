import 'package:get/get.dart';

class LanguageController extends GetxController {
  final RxString selectedLanguage = 'English'.obs;

  final List<String> availableLanguages = [
    'English',
    'Spanish',
    'French',
    'Russian',
    'Portuguese',
    'German',
    'Italian',
    'Mandarin Chinese',
    'Cantonese',
    'Arabic',
    'Hebrew',
    'Turkish',
  ];

  void changeLanguage(String language) {
    selectedLanguage.value = language;

    Get.snackbar(
      'Language Changed',
      'App language changed to $language',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}
