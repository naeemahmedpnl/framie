import 'dart:convert';
import 'dart:developer';

import 'package:beauty/service/user_session/user_session.dart';
import 'package:http/http.dart' as http;

import '../../models/salon.response.model.dart';
import '../service_constants/configs.dart';

class SalonRepository {
  Future<List<ServiceSalon>> fetchAllSalons() async {
    final Uri url = Uri.parse('$kBaseUrl/api/admin/getAllServices');
    try {
      log('Fetching all salons from: $url');

      String token = await UserSession().getUserToken();

      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});

      log(token);
      log('Response status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['success']) {
          List<ServiceSalon> services = List<ServiceSalon>.from(
            responseBody['data'].map((x) => ServiceSalon.fromJson(x)),
          );
          return services;
        } else {
          log('Failed to fetch salons: ${responseBody['msg']}');
          return [];
        }
      } else {
        log('Failed to fetch salons: ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      log('Error fetching salons: $e');
      return [];
    }
  }

  Future<List<ServiceSalon>> fetchAllSalonsServicesById(String adminID) async {
    log(adminID.toString());
    final Uri url = Uri.parse(
        '$kBaseUrl/api/admin/getAllServicesByAdminId?adminId=$adminID');
    try {
      log('Fetching all salons from: $url');

      String token = await UserSession().getUserToken();

      final response = await http.get(url);

      log(token);
      log('Response status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['success']) {
          List<ServiceSalon> services = List<ServiceSalon>.from(
            responseBody['data'].map((x) => ServiceSalon.fromJson(x)),
          );
          return services;
        } else {
          log('Failed to fetch salons: ${responseBody['msg']}');
          return [];
        }
      } else {
        log('Failed to fetch salons: ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      log('Error fetching salons: $e');
      return [];
    }
  }
}
