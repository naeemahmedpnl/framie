import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/search_and_book_services_controllers/choose_date_and_time_controller/choose_date_and_time_controller.dart';
import '../../../models/admin_models/all_employees_model.dart';
import '../../../models/busket_data_model.dart';
import '../../../models/salon.response.model.dart';
import '../../../service/user_session/user_session.dart';
import '../../service_place/haircut_and_styling/salon_details_user_view.dart';

class ChooseDateTimeScreen extends StatefulWidget {
  final String adminId;
  final ServiceSalon salon;
  final AllEmployees employe;

  const ChooseDateTimeScreen({
    super.key,
    required this.adminId,
    required this.salon,
    required this.employe,
  });

  @override
  State<ChooseDateTimeScreen> createState() => _ChooseDateTimeScreenState();
}

class _ChooseDateTimeScreenState extends State<ChooseDateTimeScreen> {
  final controller = Get.put(ChooseDateTimeController());

  @override
  void initState() {
    super.initState();
    controller.fetchEmployees(widget.adminId);
    controller.fetchSalons(widget.adminId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text("Choose Date & Time"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.purple,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  // Month Name
                  Obx(
                    () => Text(
                      controller.currentMonth.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
        
                  // Date Selector Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left Arrow
                      IconButton(
                        icon: const Icon(Icons.arrow_left, color: Colors.white),
                        onPressed: () => controller.previousMonth(),
                      ),
        
                      // Date List
                      Expanded(
                        child: Obx(
                          () => SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  List.generate(controller.dates.length, (index) {
                                var date = controller.dates[index];
                                bool isSelected =
                                    index == controller.selectedDate.value;
        
                                return GestureDetector(
                                  onTap: () async {
                                    controller.selectDate(index);
                                    // Show Time Picker
                                    TimeOfDay? pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
        
                                    if (pickedTime != null) {
                                      controller.selectedTime.value =
                                          pickedTime.format(Get.context!);
                                      showBottomSheetView(Get.context!);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          date["day"]!,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.white70,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          date["weekDay"]!,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.white60,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
        
                      // Right Arrow
                      IconButton(
                        icon: const Icon(Icons.arrow_right, color: Colors.white),
                        onPressed: () => controller.nextMonth(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
        
            // Available Stylists Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.center,
                child: Text("Available Stylists",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
        
            const SizedBox(height: 10),
        
            // Available Stylists List
            Expanded(
              child: _buildSalonsView(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSalonsView() {
    return Obx(() {
      if (controller.employees.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.78,
        ),
        itemCount: controller.employees.length,
        itemBuilder: (context, index) {
          final employee = controller.employees[index];
          return _buildStylistCard(employee);
        },
      );
    });
  }

  Widget _buildStylistCard(AllEmployees employee) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => SalonDetailsUserView(
            employees: employee,
            services: controller.salons,
          ),
        );
      },
      child: Container(

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                'https://appsdemo.pro/Framie/${employee.employeeImage}',
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 140,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(Icons.error),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.employeeName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.purple[900],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '106 Reviews',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '4.98',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
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

  // Function to show Bottom Sheet
  void showBottomSheetView(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 35,
            left: 16,
            right: 16,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                "Your Basket",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // Service Item with Remove Button
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "https://appsdemo.pro/Framie/${widget.salon.bannerImage}",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    widget.salon.title.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "60 Minutes",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  trailing: Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Choose Date & Time Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  onPressed: () async {
                    BasketDataModel basket = BasketDataModel(
                      userId: UserSession.userModel.value.id,
                      adminId: widget.salon.adminId.toString(),
                      clientName: UserSession.userModel.value.name.toString(),
                      date: controller.getFormattedDate(),
                      stylist: widget.employe.id,
                      timeSlot: controller.selectedTime.toString(),
                      price: '60',
                      createdByModel: "Admin",
                      createdBy: widget.salon.adminId.toString(),
                      services: [widget.salon.id.toString()],
                    );

                    controller.submitBusinessProfile(
                      busket: basket,
                    );
                  },
                  child: Text("Add in Basket"),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
