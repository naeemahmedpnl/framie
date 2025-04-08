import 'package:get/get.dart';

class WalletViewController extends GetxController {
  final RxBool isApplePaymentEnabled = false.obs;

  void toggleApplePayment(bool value) {
    isApplePaymentEnabled.value = value;
  }
}
