import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/services_view_controller/sub_service/view_all_subservice_view_controller.dart';

class ViewAllSubServiceByAdminIdScreen extends StatefulWidget {
  const ViewAllSubServiceByAdminIdScreen({super.key});

  @override
  State<ViewAllSubServiceByAdminIdScreen> createState() =>
      _ViewAllSubServiceByAdminIdScreenState();
}

class _ViewAllSubServiceByAdminIdScreenState
    extends State<ViewAllSubServiceByAdminIdScreen> {
  final controller = Get.put(ViewAllSubServiceByAdminIdController());

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
        title: Text("Sub Services", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.subServices.isEmpty) {
          return Center(child: Text("No Sub Services Found"));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: List.generate(controller.subServices.length, (index) {
                var subServices = controller.subServices[index];

                return Column(
                  children: [
                    ServiceCard(
                      imageUrl:
                          "Https://appsdemo.pro/Framie/${subServices.subServiceImage.first}",
                      title: subServices.title,
                      onAddTap: () {},
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
  final VoidCallback onAddTap;

  const ServiceCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onAddTap,
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
              // Positioned(
              //   top: 10,
              //   right: 10,
              //   child: GestureDetector(
              //     onTap: onAddTap,
              //     child: Container(
              //       padding: EdgeInsets.all(5),
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         shape: BoxShape.circle,
              //       ),
              //       child: Icon(
              //         Icons.add,
              //         color: Colors.black,
              //         size: 20,
              //       ),
              //     ),
              //   ),
              // ),
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
