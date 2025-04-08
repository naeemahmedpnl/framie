import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controllers/services_place_controllers/service_by_address_view_controller/services_by_address_view_controller.dart';
import '../../../models/bussiness_profile_admin.dart';
import '../haircut_and_styling/haircut_and_styling_view.dart';
import '../not_service_in/not_service_in_view.dart';

class ServiceByAddressView extends StatefulWidget {
  const ServiceByAddressView({super.key});

  @override
  State<ServiceByAddressView> createState() => _ServiceByAddressViewState();
}

class _ServiceByAddressViewState extends State<ServiceByAddressView> {
  final controller = Get.put(ServiceByAddressViewController());

  @override
  void initState() {
    super.initState();
    controller.fetchSalons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLocationBar(),
                    _buildSearchBar(),
                    _buildPromoBanner(),
                    _buildServicesSection(),
                    _buildNearbySalons(),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationBar() {
    return GestureDetector(
      onTap: () {
        Get.to(() => NotServiceInView());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Location',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 22),
                    const SizedBox(width: 4),
                    const Text(
                      'Lakewood, California',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down, size: 20),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.shopping_cart_outlined, size: 22),
                    const SizedBox(width: 12),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(Icons.notifications_outlined, size: 22),
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: controller.searchController,
          decoration: InputDecoration(
            hintText: 'Search Stylists',
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none,
            icon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: controller.searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      controller.searchController.clear();
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            debugPrint('Searching for: $value');
          },
        ),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.purple[800],
          image: const DecorationImage(
            image: AssetImage('assets/images/slider.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Colors.purple[900]!.withValues(alpha: .7),
                    Colors.purple[700]!.withValues(alpha: 0.1),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Morning Special!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Get 20% Off',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'on All Hair Treatment Between 9-10 AM.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Book Now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Services',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Obx(() => _buildServiceItem(
                      icon: Icons.spa,
                      label: 'Massage',
                      index: 0,
                    )),
                const SizedBox(width: 16),
                Obx(() => _buildServiceItem(
                      icon: Icons.healing,
                      label: 'Hair Treatment',
                      index: 1,
                    )),
                const SizedBox(width: 16),
                Obx(() => _buildServiceItem(
                      icon: Icons.colorize,
                      label: 'Hair Color',
                      index: 2,
                    )),
                const SizedBox(width: 16),
                Obx(() => _buildServiceItem(
                      icon: Icons.face_retouching_natural,
                      label: 'Facial',
                      index: 3,
                    )),
                const SizedBox(width: 16),
                Obx(() => _buildServiceItem(
                      icon: Icons.brush,
                      label: 'Makeup',
                      index: 4,
                    )),
                const SizedBox(width: 16),
                Obx(() => _buildServiceItem(
                      icon: Icons.airline_seat_flat,
                      label: 'Nail Care',
                      index: 5,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isActive = controller.selectedServiceIndex.value == index;

    return GestureDetector(
      onTap: () => controller.selectService(index),
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Color(0xff81017F) : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : Colors.grey[400],
              size: 18,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey[500],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbySalons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Nearby Salons',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.map,
                  color: Colors.blue,
                  size: 20,
                ),
                label: const Text(
                  'View on Map',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Obx(
            () {
              if (controller.isLoading.value) {
                return Column(
                  children: List.generate(
                    3,
                    (index) => buildShimmerSalonCard(),
                  ),
                );
              }

              return Column(
                children: [
                  for (BusinessDataAdmin bussiness in controller.bussiness)
                    _buildSalonCard(
                      name: bussiness.businessName,
                      location: bussiness.address,
                      rating: 0,
                      reviews: 0,
                      distance: '2 mi',
                      image: bussiness.profileImage,
                      onTap: () {
                        Get.to(
                          () => HairCutAndStylingView(
                            adminId: bussiness.adminId,
                            serviceName: bussiness.businessName,
                          ),
                        );
                      },
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSalonCard({
    required String name,
    required String location,
    required double rating,
    required int reviews,
    required String distance,
    required String image,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage('https://appsdemo.pro/Framie/$image'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rating.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '($reviews)',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        distance,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildShimmerSalonCard() {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 18,
                    width: 120,
                    color: Colors.grey[200],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(width: 4),
                      Container(
                        height: 14,
                        width: 80,
                        color: Colors.grey[200],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.grey[300],
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Container(
                            height: 14,
                            width: 30,
                            color: Colors.grey[200],
                          ),
                          const SizedBox(width: 4),
                          Container(
                            height: 14,
                            width: 40,
                            color: Colors.grey[200],
                          ),
                        ],
                      ),
                      Container(
                        height: 14,
                        width: 50,
                        color: Colors.grey[200],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
