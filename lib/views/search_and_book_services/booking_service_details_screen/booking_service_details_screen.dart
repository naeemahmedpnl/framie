// import 'package:beauty/models/salon.response.model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '/controllers/search_and_book_services_controllers/booking_service_details_controller/booking_service_details_controller.dart';
// import '/utils/widgets/custom_appbar.dart';
// import '/utils/widgets/custom_button.dart';
// import '/views/search_and_book_services/choose_date_and_time_Screen/choose_date_time_screen.dart';
// import '../../../models/admin_models/all_employees_model.dart';

// class BookingServiceDetailsScreen extends StatefulWidget {
//   final ServiceSalon salon;
//   final AllEmployees employees;
//   const BookingServiceDetailsScreen({
//     super.key,
//     required this.salon,
//    required this.employees,
//   });

//   @override
//   State<BookingServiceDetailsScreen> createState() =>
//       _BookingServiceDetailsScreenState();
// }

// class _BookingServiceDetailsScreenState
//     extends State<BookingServiceDetailsScreen> {
//   final BookingServiceDetailsController controller =
//       Get.put(BookingServiceDetailsController());

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: CustomAppBar(title: "Booking"),
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               ClipRRect(
// //                 borderRadius: BorderRadius.circular(12),
// //                 child: SizedBox(
// //                   width: double.infinity,
// //                   height: 300,
// //                   child: Image.network(
// //                     "https://appsdemo.pro/Framie/${widget.salon.bannerImage}",
// //                     fit: BoxFit.cover,
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               Text(
// //                 widget.salon.title.toString(),
// //                 style: TextStyle(
// //                   fontSize: 24,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.purple,
// //                 ),
// //               ),
// //               const SizedBox(height: 4),
// //               Text(
// //                 widget.salon.text.toString(),
// //                 style: TextStyle(color: Colors.grey.shade600),
// //               ),
// //               const SizedBox(height: 16),
        
// //               // Dropdowns
// //               buildDropdownWithIcon(
// //                   "assets/images/clock.png",
// //                   "Duration",
// //                   controller.durations,
// //                   controller.selectedDuration,
// //                   controller.updateDuration,
// //                   showDropdownIcon: true),
// //               const SizedBox(height: 8),
// //               buildDropdownWithIcon(
// //                   "assets/images/person.png",
// //                   "You've Got",
// //                   controller.conditions,
// //                   controller.selectedCondition,
// //                   controller.updateCondition),
// //               const SizedBox(height: 8),
// //               buildDropdownWithIcon(
// //                   "assets/images/pressure.png",
// //                   "Pressure",
// //                   controller.pressures,
// //                   controller.selectedPressure,
// //                   controller.updatePressure),
// //               const SizedBox(height: 16),
        
// //               // Sections
// //               buildSection("Benefits"),
// //               buildSection("Our recommendation"),
// //               buildSection("During your treatment"),
// //               buildSection("Questions before your treatment?"),
// //               buildSection("Probably not the treatment for you if"),
// //               const SizedBox(height: 16),
        
// //               CustomButton(
// //                 text: 'Book Now',
// //                 onPressed: () {
// //                   showBottomSheetView(context);
// //                 },
// //               ),
        
// //               SizedBox(height: 20),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   // Function to show Bottom Sheet
// //   void showBottomSheetView(BuildContext context) {
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.white,
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
// //       ),
// //       builder: (context) {
// //         return Padding(
// //           padding: const EdgeInsets.all(30),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [ 
// //               // Title
// //               Text(
// //                 "Your Basket",
// //                 style: TextStyle(
// //                   fontSize: 18,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),

// //               const SizedBox(height: 10),

// //               // Service Item with Remove Button
// //               Container(
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(12),
// //                   border: Border.all(color: Colors.grey.shade300),
// //                 ),
// //                 child: ListTile(
// //                   leading: ClipRRect(
// //                     borderRadius: BorderRadius.circular(8),
// //                     child: Image.network(
// //                       "https://appsdemo.pro/Framie/${widget.salon.bannerImage}",
// //                       width: 50,
// //                       height: 50,
// //                       fit: BoxFit.cover,
// //                     ),
// //                   ),
// //                   title: Text(
// //                     widget.salon.title.toString(),
// //                     style: TextStyle(
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                   subtitle: Text(
// //                     "60 Minutes",
// //                     style: TextStyle(
// //                       color: Colors.grey.shade600,
// //                     ),
// //                   ),
// //                   trailing: Icon(
// //                     Icons.close,
// //                     color: Colors.grey,
// //                   ),
// //                   onTap: () {
// //                     Get.back();
// //                   },
// //                 ),
// //               ),

// //               const SizedBox(height: 10),

// //               // Add Another Treatment
// //               Text(
// //                 "Add Another Treatment",
// //                 style: TextStyle(
// //                   fontSize: 16,
// //                   color: Colors.purple,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),

// //               const SizedBox(height: 20),

// //               // Choose Date & Time Button
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     padding: EdgeInsets.symmetric(vertical: 15),
// //                     shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(30)),
// //                     backgroundColor: Colors.purple,
// //                     foregroundColor: Colors.white,
// //                     textStyle: TextStyle(fontSize: 16),
// //                   ),
// //                   onPressed: () {
// //                     Navigator.of(context).pop;
// //                     Get.to(
// //                       () => ChooseDateTimeScreen(
                  
                  
// //                       ),
// //                     );
// //                   },
// //                   child: Text("Choose Date & Time"),
// //                 ),
// //               ),

// //               const SizedBox(height: 30),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   // Dropdown with Icons (Only "Options" has dropdown icon)
// //   Widget buildDropdownWithIcon(String iconPath, String label,
// //       List<String> items, RxString selectedValue, Function(String) onChanged,
// //       {bool showDropdownIcon = false}) {
// //     return Obx(
// //       () => Container(
// //         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //         decoration: BoxDecoration(
// //           border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
// //         ),
// //         child: Row(
// //           children: [
// //             Image.asset(iconPath, width: 20, height: 20), // Custom icon
// //             const SizedBox(width: 8),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(label,
// //                       style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.grey.shade700)),
// //                   DropdownButtonHideUnderline(
// //                     child: DropdownButton<String>(
// //                       value: selectedValue.value,
// //                       isExpanded: true,
// //                       onChanged: (value) => onChanged(value!),
// //                       icon: showDropdownIcon
// //                           ? Icon(Icons.arrow_drop_down)
// //                           : SizedBox.shrink(),
// //                       items: items.map((String item) {
// //                         return DropdownMenuItem<String>(
// //                           value: item,
// //                           child: Text(item),
// //                         );
// //                       }).toList(),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // Section Builder
// //   Widget buildSection(String title) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 8),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(title,
// //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
// //           const SizedBox(height: 4),
// //           Text(
// //             "Lorem ipsum is simply dummy text of the printing and typesetting industry.",
// //             style: TextStyle(color: Colors.grey.shade700),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }



import 'package:beauty/models/sub_services_salon_model.dart';
import 'package:beauty/utils/widgets/custom_appbar.dart';
import 'package:beauty/utils/widgets/custom_button.dart';
import 'package:beauty/views/search_and_book_services/choose_date_and_time_Screen/choose_date_time_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingServiceDetailsScreen extends StatefulWidget {
  final SubService subService;
  final AssignedEmployee? selectedEmployee;

  const BookingServiceDetailsScreen({
    Key? key,
    required this.subService,
    this.selectedEmployee,
  }) : super(key: key);

  @override
  State<BookingServiceDetailsScreen> createState() => _BookingServiceDetailsScreenState();
}

class _BookingServiceDetailsScreenState extends State<BookingServiceDetailsScreen> {
  final RxString selectedDuration = "60 Minutes".obs;
  final RxString selectedCondition = "Normal".obs;
  final RxString selectedPressure = "Medium".obs;
  
  final List<String> durations = ["30 Minutes", "60 Minutes", "90 Minutes"];
  final List<String> conditions = ["Dry", "Normal", "Oily"];
  final List<String> pressures = ["Light", "Medium", "Firm"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Booking"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: widget.subService.subServiceImage.isNotEmpty
                    ? Image.network(
                        "https://appsdemo.pro/Framie/${widget.subService.subServiceImage.first}",
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 300,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported, size: 50),
                        ),
                      )
                    : Container(
                        height: 300,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 50),
                      ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Service Title and Description
              Text(
                widget.subService.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.subService.text,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16),
              
              // Dropdowns
              buildDropdownWithIcon(
                "assets/images/clock.png",
                "Duration",
                durations,
                selectedDuration,
                (value) => selectedDuration.value = value,
                showDropdownIcon: true
              ),
              const SizedBox(height: 8),
              buildDropdownWithIcon(
                "assets/images/person.png",
                "You've Got",
                conditions,
                selectedCondition,
                (value) => selectedCondition.value = value
              ),
              const SizedBox(height: 8),
              buildDropdownWithIcon(
                "assets/images/pressure.png",
                "Pressure",
                pressures,
                selectedPressure,
                (value) => selectedPressure.value = value
              ),
              const SizedBox(height: 16),
              
              // Sections
              buildSection("Benefits"),
              buildSection("Our recommendation"),
              buildSection("During your treatment"),
              buildSection("Questions before your treatment?"),
              buildSection("Probably not the treatment for you if"),
              const SizedBox(height: 16),
              
              // Book Now Button
              CustomButton(
                text: 'Book Now',
                onPressed: () {
                  showBottomSheetView(context);
                },
              ),
              
              const SizedBox(height: 20),
            ],
          ),
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [ 
              // Title
              const Text(
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
                    child: widget.subService.subServiceImage.isNotEmpty
                      ? Image.network(
                          "https://appsdemo.pro/Framie/${widget.subService.subServiceImage.first}",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 50,
                            height: 50,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported, size: 20),
                          ),
                        )
                      : Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported, size: 20),
                        ),
                  ),
                  title: Text(
                    widget.subService.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    selectedDuration.value,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),

              const SizedBox(height: 10),

              // Add Another Treatment
              const Text(
                "Add Another Treatment",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Choose Date & Time Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.pop(context);  // Close the bottom sheet
                    Get.to(
                      () => ChooseDateTimeScreen(
                        subService: widget.subService, 
                        duration: '',

                      ),
                    );
                  },
                  child: const Text("Choose Date & Time"),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  // Dropdown with Icons (Only "Options" has dropdown icon)
  Widget buildDropdownWithIcon(
    String iconPath, 
    String label,
    List<String> items, 
    RxString selectedValue, 
    Function(String) onChanged,
    {bool showDropdownIcon = false}
  ) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                  Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700
                    )
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedValue.value,
                      isExpanded: true,
                      onChanged: (value) => onChanged(value!),
                      icon: showDropdownIcon
                          ? const Icon(Icons.arrow_drop_down)
                          : const SizedBox.shrink(),
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
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            )
          ),
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