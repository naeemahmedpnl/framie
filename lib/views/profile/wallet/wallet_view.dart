import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/profile/wallet_view_controller.dart';
import '../../../utils/constants/view_consants.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WalletViewController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Payment Method',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
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
            onPressed: () {
              // Show help dialog
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            _buildPaymentMethod(
              icon: Image.asset(
                'assets/icons/visa.png',
                width: 40,
                height: 25,
              ),
              title: 'VISA',
              cardNumber: '**** 0948',
              amount: '£1200',
            ),
            const Divider(height: 1),
            _buildPaymentMethod(
              icon: Image.asset(
                'assets/icons/apple.png',
                width: 40,
                height: 30,
              ),
              title: 'Apple Pay',
              cardNumber: '**** 0948',
              amount: '£1200',
            ),
            const Divider(height: 1),
            _buildAddPaymentMethod(),
            const Divider(height: 1),
            SizedBox(height: 16),
            _buildApplePaymentToggle(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod({
    required Widget icon,
    required String title,
    required String cardNumber,
    required String amount,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          SizedBox(width: 40, child: icon),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                cardNumber,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
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
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddPaymentMethod() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(kPaymentMethodScreenRoute);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: const Icon(
                Icons.add,
                size: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'New Payment Method',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            CircleAvatar(
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
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplePaymentToggle() {
    final controller = Get.put(WalletViewController());

    return Row(
      children: [
        Obx(() => Switch(
              value: controller.isApplePaymentEnabled.value,
              onChanged: controller.toggleApplePayment,
              activeTrackColor: Colors.purple.shade200,
              activeColor: Colors.purple,
            )),
        const SizedBox(width: 12),
        const Text(
          'Apple Payment',
          style: TextStyle(
            fontSize: 16,
            color: Colors.purple,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
