import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/services_view_controller/service_controller/service_controller.dart';
import '../edit_service_screen/edit_service_screen.dart';
import '../sub_service/add_sub_service_view.dart';
import '../sub_service/view_all_subservices_by_admin.dart';
import '../sub_service/view_sub_service_view.dart';

class ServiceByAdminIdScreen extends StatefulWidget {
  const ServiceByAdminIdScreen({super.key});

  @override
  State<ServiceByAdminIdScreen> createState() => _ServiceByAdminIdScreenState();
}

class _ServiceByAdminIdScreenState extends State<ServiceByAdminIdScreen> {
  final ServiceController controller = Get.put(ServiceController());

  @override
  void initState() {
    super.initState();
    controller.fetchSalons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F7FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Services", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => ViewAllSubServiceByAdminIdScreen());
            },
            icon: Image.asset(
              'assets/icons/bookings.png',
              color: Colors.black,
              height: 25,
              fit: BoxFit.contain,
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.salons.isEmpty) {
          return Center(child: Text("No Services Found"));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: List.generate(controller.salons.length, (index) {
                var salon = controller.salons[index];

                return Column(
                  children: [
                    ServiceCard(
                      imageUrl:
                          "Https://appsdemo.pro/Framie/${salon.bannerImage}",
                      title: salon.title ?? "Service Name",
                      onTap: () {
                        Get.to(() => EditServiceScreen(salon: salon));
                      },
                      onAddTap: () {
                        Get.to(() => AddSubServiceView(salon: salon));
                      },
                      onViewTap: () {
                        Get.to(
                          () => SubServiceByServiceIdScreen(
                            serviceId: salon.id.toString(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                  ],
                );
              }),
            ),
          ),
        );
      }),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onTap;
  final VoidCallback onAddTap;
  final VoidCallback onViewTap;

  const ServiceCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onTap,
    required this.onAddTap,
    required this.onViewTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: onAddTap,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: onTap,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: onViewTap,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.remove_red_eye,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
