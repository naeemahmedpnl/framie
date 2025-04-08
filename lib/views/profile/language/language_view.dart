import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/profile/language_view_controller.dart';

class LanguagesView extends StatelessWidget {
  const LanguagesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LanguageController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Languages',
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
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: controller.availableLanguages.length,
        separatorBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: const Divider(height: 1),
        ),
        itemBuilder: (context, index) {
          final language = controller.availableLanguages[index];
          final isSelected = controller.selectedLanguage.value == language;

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            title: Text(
              language,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: Colors.black87,
              ),
            ),
            onTap: () => controller.changeLanguage(language),
            trailing: isSelected
                ? const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 20,
                  )
                : null,
          );
        },
      ),
    );
  }
}
