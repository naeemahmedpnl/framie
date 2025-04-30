import 'dart:developer';

import 'package:beauty/views/admin_auth/all_employee_screen/all_employee_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/profile/setting_profile_view_controller.dart';
import '../../../service/user_session/user_session.dart';
import '../../../utils/constants/view_consants.dart';
import '../../bussiness/bussines_profile_view.dart';
import '../chat_with_support/chat_with_support.dart';
import '../logout/logout_view.dart';

class SettingProfileView extends StatefulWidget {
  const SettingProfileView({super.key});

  @override
  State<SettingProfileView> createState() => _SettingProfileViewState();
}

class _SettingProfileViewState extends State<SettingProfileView> {
  final controller = Get.put(SettingProfileController());

  @override
  void initState() {
    super.initState();
    controller.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/profile_bg.png'),
                  fit: BoxFit.cover,
                ),
                color: Colors.purple[800],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Avatar with initials
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.purple[200],
                    child: Obx(
                      () {
                        log(UserSession.userModel.value.name.toString());
                        String name =
                            UserSession.userModel.value.name.toString();
                        String initials = name.isNotEmpty
                            ? name
                                .trim()
                                .split(" ")
                                .map((e) => e[0])
                                .take(2)
                                .join()
                                .toUpperCase()
                            : "";

                        return Text(
                          initials,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 16),
                  // User info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            UserSession.userModel.value.name.toString(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Obx(
                          () => Text(
                            UserSession.userModel.value.email.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Navigation arrow
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),

            // Menu items
            _buildMenuItem(
              icon: Icons.settings,
              title: "Account Settings",
              color: Colors.purple,
              onTap: () {
                Get.toNamed(kAccountSettingsViewRoute);
              },
            ),
            Obx(
              () => controller.isAdmin.value
                  ? _buildMenuItem(
                      icon: Icons.museum,
                      title: "Bussiness Profile",
                      color: Colors.purple,
                      onTap: () {
                        Get.to(() => BussinessProfileView());
                      },
                    )
                  : SizedBox(),
            ),

            Obx(
              () => controller.isAdmin.value
                  ? _buildMenuItem(
                      icon: Icons.people,
                      title: "Employees",
                      color: Colors.purple,
                      onTap: () {
                        Get.to(
                          () => EmployeeScreen(
                            adminId: UserSession.userModel.value.id,
                          ),
                        );
                      },
                    )
                  : SizedBox(),
            ),
            _buildMenuItem(
                icon: Icons.chat_bubble,
                title: "Inbox",
                color: Colors.purple,
                onTap: () {
                  Get.toNamed(kHelpViewControllerRoute);
                }),
            _buildMenuItem(
                icon: Icons.credit_card_sharp,
                title: "Payment Method",
                color: Colors.purple,
                onTap: () {
                  Get.toNamed(kWalletViewRoute);
                }),
            _buildMenuItem(
                icon: Icons.chat,
                title: "Chat With Support",
                color: Colors.purple,
                onTap: () {
                  Get.to(() => ChatWithSupport());
                }),
            // _buildMenuItem(
            //     icon: Icons.language,
            //     title: "Language",
            //     color: Colors.purple,
            //     onTap: () {
            //       Get.toNamed(kLanguagesViewRoute);
            //     }),
            _buildMenuItem(
                icon: Icons.info,
                title: "About The App",
                color: Colors.purple,
                onTap: () {
                  Get.toNamed(kAboutAppViewRoute);
                }),
            _buildMenuItem(
              icon: Icons.home,
              title: "Addresses",
              color: Colors.purple,
              onTap: () {
                Get.toNamed(kMyAddressesScreenRoute);
              },
            ),

            // Logout button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: GestureDetector(
                onTap: () {
                  Get.dialog(
                    const LogoutDialog(),
                    barrierDismissible: false,
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.purple[400],
                    ),
                    const SizedBox(width: 16),
                    Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.purple[400],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required Color color,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withValues(alpha: .2),
              width: 1,
            ),
          ),
        ),
        child: ListTile(
          leading: Icon(icon, color: color),
          title: Text(title),
          trailing: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.white,
            foregroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              padding: EdgeInsets.all(4),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
