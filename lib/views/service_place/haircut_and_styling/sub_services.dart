// import 'dart:convert';
// import 'dart:developer';

// import 'package:beauty/models/admin_models/all_employees_model.dart';
// import 'package:beauty/models/sub_services_salon_model.dart';
// import 'package:beauty/views/service_place/haircut_and_styling/confirm_booking_stylist_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:http/http.dart' as http;

// class SubServicesView extends StatefulWidget {
//   final String serviceId;
//   final AllEmployees? employee;

//   const SubServicesView({
//     required this.serviceId,
//      this.employee,
//   });

//   @override
//   State<SubServicesView> createState() => _SubServicesViewState();
// }

// class _SubServicesViewState extends State<SubServicesView> {
//   List<SubService> subServices = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchSubServices();
//   }

//   static const String baseUrl = 'https://appsdemo.pro/Framie';

//   Future<void> fetchSubServices() async {
//     try {
//       // Make API call
//       final response = await http.get(Uri.parse(
//           '$baseUrl/api/admin/getSubServicesByServiceId?serviceId=${widget.serviceId}'));

//       log('Response status code: ${response.statusCode}');
//       log('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['success']) {
//           final subServicesData = data['data'] as List;
//           subServices =
//               subServicesData.map((e) => SubService.fromJson(e)).toList();
//         }

//         log('SubServices: ${subServices.length}');
//         log('SubServices: ${subServices.map((e) => e.title).toList()}');
//       }
//     } catch (e) {
//       log('Error fetching subservices: $e');
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Service'),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               padding: EdgeInsets.all(16),
//               itemCount: subServices.length,
//               itemBuilder: (context, index) {
//                 final subService = subServices[index];
//                 return _buildSubServiceCard(subService);
//               },
//             ),
//     );
//   }

//   Widget _buildSubServiceCard(SubService subService) {
//   return Card(
//     margin: const EdgeInsets.only(bottom: 16),
//     elevation: 3,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     child: Column(
//       children: [
//         Stack(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//               child: Image.network(
//                 'https://appsdemo.pro/Framie/${subService.subServiceImage.first}',
//                 height: 200,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => Container(
//                   height: 200,
//                   color: Colors.grey[300],
//                   child: Icon(Icons.image_not_supported, size: 50),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 10,
//               right: 10,
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: Colors.purple.withOpacity(0.8),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.star, color: Colors.amber, size: 18),
//                     SizedBox(width: 4),
//                     Text(
//                    '${subService.servicePoints ?? 0} points',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 20,
//               left: 0,
//               right: 0,
//               child: Center(
//                 child: SizedBox(
//                   width: 180,
//                   height: 45,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (widget.employee != null) {
//                         Get.to(() => ConfirmBookingStylistScreen(
//                               serviceName: subService.title,
//                               employees: widget.employee!,
//                               subService: subService, 
//                             ));
//                       } else {
//                         // Handle the case when employee is null
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Please select a stylist first')),
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.purple,
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       elevation: 4,
//                     ),
//                     child: const Text(
//                       "Book Now",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   subService.title,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: Colors.purple[50],
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   '\$${subService.price.toStringAsFixed(2)}',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.purple[900],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//           child: Text(
//             subService.text,
//             style: TextStyle(
//               color: Colors.grey[700],
//               height: 1.4,
//             ),
//             maxLines: 3,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     ),
//   );
// }}




import 'dart:convert';
import 'dart:developer';

import 'package:beauty/models/sub_services_salon_model.dart';
import 'package:beauty/views/service_place/haircut_and_styling/confirm_booking_stylist_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SubServicesView extends StatefulWidget {
  final String serviceId;

  const SubServicesView({
    Key? key,
    required this.serviceId,
  }) : super(key: key);

  @override
  State<SubServicesView> createState() => _SubServicesViewState();
}

class _SubServicesViewState extends State<SubServicesView> {
  List<SubService> subServices = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSubServices();
  }

  static const String baseUrl = 'https://appsdemo.pro/Framie';

  Future<void> fetchSubServices() async {
    try {
      // Make API call
      final response = await http.get(Uri.parse(
          '$baseUrl/api/admin/getSubServicesByServiceId?serviceId=${widget.serviceId}'));

      log('Response status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final subServicesModel = SubServicesModel.fromJson(jsonData);
        
        if (subServicesModel.success) {
          setState(() {
            subServices = subServicesModel.data;
            isLoading = false;
          });
          
          log('SubServices: ${subServices.length}');
          log('SubServices: ${subServices.map((e) => e.title).toList()}');
        } else {
          // Handle unsuccessful response
          setState(() {
            isLoading = false;
          });
          _showErrorSnackbar('Failed to load services: ${subServicesModel.msg}');
        }
      } else {
        // Handle non-200 response
        setState(() {
          isLoading = false;
        });
        _showErrorSnackbar('Server error: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching subservices: $e');
      setState(() {
        isLoading = false;
      });
      _showErrorSnackbar('Error: ${e.toString()}');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Service'),
        centerTitle: true,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : subServices.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: subServices.length,
                  itemBuilder: (context, index) {
                    final subService = subServices[index];
                    return _buildSubServiceCard(subService);
                  },
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No services available',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try selecting a different service category',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildSubServiceCard(SubService subService) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: subService.subServiceImage.isNotEmpty
                    ? Image.network(
                        'https://appsdemo.pro/Framie/${subService.subServiceImage.first}',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported, size: 50),
                        ),
                      )
                    : Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 50),
                      ),
              ),
              if (subService.servicePoints != null)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          '${subService.servicePoints} points',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: SizedBox(
                    width: 180,
                    height: 45,
                    child: ElevatedButton(
                    onPressed: () {
                    {
                        Get.to(() => ConfirmBookingStylistScreen(
                        
                 
                              subService: subService, 
                            ));
                      } 
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 4,
                    ),
                      child: const Text(
                        "Book Now",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    subService.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '\$${subService.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[900],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              subService.text,
              style: TextStyle(
                color: Colors.grey[700],
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}