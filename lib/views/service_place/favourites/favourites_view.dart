import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/services_place_controllers/favourite_view_controller/favourite_view_controller.dart';
import '../../../models/salon.response.model.dart';
import '../haircut_and_styling/haircut_and_styling_view.dart';
import 'add_favourite_view.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteViewController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Favourite',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Container(
              decoration: BoxDecoration(
                color: Color(0xffA83F98),
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(right: 5),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Row(
                children: [
                  Text(
                    0.toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                ],
              )),
        ],
      ),
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return _buildUpcomingTab();
        }
        return ListView.builder(
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            return _buildTreatmentCard(
              controller.favorites[index],
              controller,
            );
          },
        );
      }),
    );
  }

  Widget _buildTreatmentCard(
    ServiceSalon salon,
    FavouriteViewController controller,
  ) {
    return InkWell(
      onTap: () {
        Get.to(
          () => HairCutAndStylingView(
            adminId: salon.adminId.toString(),
            serviceName: salon.title.toString(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: 24,
          left: 10,
          right: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    'https://appsdemo.pro/Framie/${salon.bannerImage}',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 15,
                  child: Obx(
                    () => CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {
                          controller.toggleFavorite(salon);
                          controller.onInit();
                        },
                        icon: Icon(
                          controller.isFavorite(salon)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: controller.isFavorite(salon)
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                salon.title.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingTab() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty state placeholders (similar to the screenshot)
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                padding: EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    height: 80,
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 12,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                height: 12,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Column(
              children: [
                Text(
                  "Favorites",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D055E),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "You haven't picked any favorites - tap the heart on your go-to salons and stylist's profile!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                CupertinoButton(
                  onPressed: () {
                    Get.to(() => AddFavoritesScreen());
                  },
                  padding: EdgeInsets.all(0),
                  child: Text(
                    "Add Favourite",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5D055E),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
