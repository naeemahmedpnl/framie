import 'package:beauty/views/profile/help/chatlist_screen.dart';
import 'package:beauty/views/profile/help/chat.dart';
import 'package:get/get.dart';

import '/views/auth/login/login_screen.dart';
import '../../controllers/binding/binding.dart';
import '../../views/auth/otp/otp_screen.dart';
import '../../views/auth/signup/signup_screen.dart';
import '../../views/bussiness/admin/admin_dashboard_view.dart';
import '../../views/bussiness/bussiness_profile_create_view.dart';
import '../../views/bussiness/multi_service_profile_create_view.dart';
import '../../views/nav_menu/navigation_menu.dart';
import '../../views/onboarding/onboarding_view.dart';
import '../../views/profile/about/about_view.dart';
import '../../views/profile/account/account_setting_view.dart';
import '../../views/profile/address/add_address_view.dart';
import '../../views/profile/address/edit_address_view.dart';
import '../../views/profile/address/myaddress_view.dart';

import '../../views/profile/language/language_view.dart';
import '../../views/profile/setting/setting_profile_view.dart';
import '../../views/profile/wallet/add_new_payment_view.dart';
import '../../views/profile/wallet/wallet_view.dart';
import '../../views/service_place/appointment/appointment_view.dart';
import '../../views/service_place/booking/booking_view.dart';
import '../../views/service_place/favourites/favourites_view.dart';
import '../../views/service_place/haircut_and_styling/haircut_and_styling_view.dart';
import '../../views/service_place/not_service_in/not_service_in_view.dart';
import '../../views/service_place/service_in/service_in_view.dart';
import '../../views/service_place/services_by_address/services_by_address_view.dart';
import '../../views/splash/splash_view.dart';
import '../constants/view_consants.dart';

class RouteGenerator {
  static List<GetPage> getPages() {
    return [
      GetPage(
        name: kOnboardingViewRoute,
        page: () => const OnboardingScreen(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kAppointmentViewRoute,
        page: () => const AppointmentScreen(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kServiceInViewRoute,
        page: () => const ServiceInView(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kNotServiceInViewRoute,
        page: () => const NotServiceInView(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kNavigationMenuViewRoute,
        page: () => const NavigationMenu(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kServiceByAddressViewRoute,
        page: () => const ServiceByAddressView(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kHairCutAndStylingViewRoute,
        page: () => const HairCutAndStylingView(
          adminId: '',
          serviceName: '',
        ),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kBookingDetailsViewRoute,
        page: () => const BookingDetailsScreen(),
        binding: ControllerBinder(),
      ),
      //  GetPage(
      //   name: kBookingDetailsViewRoute,
      //   page: () => const BookingDetailsScreen(),
      //   binding: ControllerBinder(),
      // ),
      GetPage(
        name: kLoginViewRoute,
        page: () => const LoginScreen(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kSignUpViewRoute,
        page: () => const SignUpScreen(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kOTPVerificationViewRoute,
        page: () => const OTPVerificationScreen(
          otp: '',
          userId: '',
          email: '',
        ),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kFavouritesViewRoute,
        page: () => const FavouritesView(),
        binding: ControllerBinder(),
      ),
      // GetPage(
      //   name: kBookingReceiptDetailsViewRoute,
      //   page: () => const BookingReceiptDetailsView(),
      //   binding: ControllerBinder(),
      // ),
      GetPage(
        name: kSettingProfileViewRoute,
        page: () => const SettingProfileView(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kWalletViewRoute,
        page: () => const WalletView(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kAccountSettingsViewRoute,
        page: () => const AccountSettingsView(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kAboutAppViewRoute,
        page: () => const AboutAppView(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kLanguagesViewRoute,
        page: () => const LanguagesView(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kEditAddressViewRoute,
        page: () => const EditAddressView(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kMyAddressesScreenRoute,
        page: () => const MyAddressesScreen(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kAddAddressScreenRoute,
        page: () => const AddAddressScreen(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kPaymentMethodScreenRoute,
        page: () => const PaymentMethodScreen(),
        binding: ControllerBinder(),
      ),

      GetPage(
        name: '/chat/:chatId/:recipientName',
        page: () => ChatScreen(
          chatId: Get.parameters['chatId']!,
          recipientName: Get.parameters['recipientName']!,
        ),
      ),
      GetPage(
        name: kHelpViewControllerRoute,
        page: () =>  ChatsListScreen(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kSplashViewRoute,
        page: () => const SplashView(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kBusinessProfileCraeteViewRoute,
        page: () => const BusinessProfileCraeteView(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kCreateProfileServiceProfileCreateViewRoute,
        page: () => const CreateProfileServiceProfileCreateView(),
        binding: ControllerBinder(),
      ),
      GetPage(
        name: kAdminDashboardScreenRoute,
        page: () => const AdminDashboardScreen(),
        binding: ControllerBinder(),
      ),
    ];
  }
}
