// lib/services/api_service.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService extends GetxService {
  static const String baseUrl = 'https://appsdemo.pro/Framie';

// Method to get total customers
  Future<Map<String, dynamic>> getTotalCustomers(String adminId, String type) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/admin/getTotalCustomers?adminId=$adminId&type=$type'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load customer data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching customer data: $e');
    }
  }
}

// Initialize the service with lazy initialization
void initApiService() {
  // LazyPut will only initialize the service when it's first requested
  if (!Get.isRegistered<ApiService>()) {
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
  }
}