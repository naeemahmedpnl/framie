import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/search_and_book_services_controllers/booking_service_details_controller/booking_service_details_controller.dart';
import '/utils/widgets/custom_appbar.dart';
import '/utils/widgets/custom_button.dart';

class BookingConfirmDetailScreen extends StatefulWidget {
  const BookingConfirmDetailScreen({super.key});

  @override
  State<BookingConfirmDetailScreen> createState() =>
      _BookingConfirmDetailScreenState();
}

class _BookingConfirmDetailScreenState
    extends State<BookingConfirmDetailScreen> {
  final BookingServiceDetailsController controller =
      Get.put(BookingServiceDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Booking"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/images/booking_screen.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Haircut & Styling",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
            ),
            const SizedBox(height: 4),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),

            // Dropdowns
            buildDropdownWithIcon(
                "assets/images/clock.png",
                "Duration",
                controller.durations,
                controller.selectedDuration,
                controller.updateDuration,
                showDropdownIcon: true),
            const SizedBox(height: 8),
            buildDropdownWithIcon(
                "assets/images/person.png",
                "You've Got",
                controller.conditions,
                controller.selectedCondition,
                controller.updateCondition),
            const SizedBox(height: 8),
            buildDropdownWithIcon(
                "assets/images/pressure.png",
                "Pressure",
                controller.pressures,
                controller.selectedPressure,
                controller.updatePressure),
            const SizedBox(height: 16),

            // Sections
            buildSection("Benefits"),
            buildSection("Our recommendation"),
            buildSection("During your treatment"),
            buildSection("Questions before your treatment?"),
            buildSection("Probably not the treatment for you if"),
            const SizedBox(height: 16),

            CustomButton(
              text: 'Book Now',
              onPressed: () {
                showBottomSheetView(context);
              },
            ),

            SizedBox(height: 20),
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
          padding: const EdgeInsets.all(16),
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
                    child: Image.asset(
                      "assets/images/booking_screen.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text("Haircut & Styling",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("60 Minutes",
                      style: TextStyle(color: Colors.grey.shade600)),
                  trailing: Icon(Icons.close, color: Colors.grey),
                  onTap: () {
                    // Handle removing the selected service
                  },
                ),
              ),

              const SizedBox(height: 10),

              // Add Another Treatment
              Text("Add Another Treatment",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.purple,
                      fontWeight: FontWeight.bold)),

              const SizedBox(height: 20),

              // Choose Date & Time Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    // Get.to(() => ChooseDateTimeScreen(
                    //       adminId: '',
                    //     ));
                  },
                  child: Text("Choose Date & Time"),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // Dropdown with Icons (Only "Options" has dropdown icon)
  Widget buildDropdownWithIcon(String iconPath, String label,
      List<String> items, RxString selectedValue, Function(String) onChanged,
      {bool showDropdownIcon = false}) {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, width: 20, height: 20), // Custom icon
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700)),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedValue.value,
                      isExpanded: true,
                      onChanged: (value) => onChanged(value!),
                      icon: showDropdownIcon
                          ? Icon(Icons.arrow_drop_down)
                          : SizedBox.shrink(),
                      items: items.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
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

  // Section Builder
  Widget buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(
            "Lorem ipsum is simply dummy text of the printing and typesetting industry.",
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
