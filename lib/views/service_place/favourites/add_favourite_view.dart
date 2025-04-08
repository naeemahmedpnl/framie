// UI Screen
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/profile/add_favourite_view_controller.dart';

class AddFavoritesScreen extends StatelessWidget {
  const AddFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get controller instance
    final controller = Get.put(AddFavoritesController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            _buildAppBar(controller),

            // Content
            Expanded(
              child: Obx(() {
                if (controller.favorites.isEmpty) {
                  return _buildEmptyState(controller);
                } else {
                  return _buildFavoritesList(controller);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(AddFavoritesController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          const Text(
            'Favorites',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          // Cart badge
          Obx(() => Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFAA2288),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${controller.cartCount.value}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildFavoritesList(AddFavoritesController controller) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.favorites.length,
      itemBuilder: (context, index) {
        final item = controller.favorites[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              // Treatment card
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    item.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Title
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              // Divider
              const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(AddFavoritesController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Favorites',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF660066),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'You haven\'t picked any favorites - tap\nthe heart on your go-to salons and\nstylist\'s profile!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 30),
          TextButton(
            onPressed: () => controller.addFavorite(),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFAA2288),
            ),
            child: const Text(
              'Add Favorite',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
