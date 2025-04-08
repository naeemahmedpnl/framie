import 'package:beauty/service/user_session/user_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/profile/account_settings_view_controller.dart';
import '../../../utils/widgets/custom_button.dart';

class AccountSettingsView extends StatefulWidget {
  const AccountSettingsView({super.key});

  @override
  State<AccountSettingsView> createState() => _AccountSettingsViewState();
}

class _AccountSettingsViewState extends State<AccountSettingsView> {
  final controller = Get.put(AccountSettingsController());
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  @override
  void initState() {
    super.initState();
    initiliseData();
  }

  initiliseData() async {
    nameController.text = UserSession.userModel.value.name.toString();
    phoneController.text = UserSession.userModel.value.phNumber.toString();

    cityController.text = UserSession.userModel.value.city.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Account Settings',
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
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            _buildSettingsField(
              label: 'Name',
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your name',
                ),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
            const Divider(),
            _buildSettingsField(
              label: 'Phone No',
              child: TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your phone number',
                ),
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
            const Divider(),
            _buildSettingsField(
              label: 'City',
              child: TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your City',
                ),
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 20),
            _buildSectionHeader('Other Settings'),
            InkWell(
              onTap: controller.showDeleteConfirmation,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  'Delete My Account',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.purple.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const Divider(),
            const Spacer(),
            Obx(
              () => Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: CustomButton(
                  text: 'Save Changes',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.saveChanges(
                      city: cityController.text,
                      name: nameController.text,
                      phone: phoneController.text,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsField({required String label, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}
