import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

import '../../models/admin_models/admin.sub.service.model.dart';
import '../../models/bussiness_profile_admin.dart';
import '../../models/sub_services_salon_model.dart';
import '../service_constants/configs.dart';
import '../user_session/user_session.dart';

class SubSalonRepository {
  Future<Map<String, dynamic>> createSubSalon({
    required AddSubService subService,
    required File businessImage,
  }) async {
    final Uri url = Uri.parse('$kBaseUrl/api/admin/addSubService');

    try {
      // Create a multipart request
      var request = http.MultipartRequest('POST', url);

      // Add text fields
      request.fields['adminId'] = subService.adminId;
      request.fields['serviceId'] = subService.serviceId;
      request.fields['text'] = subService.text;
      request.fields['title'] = subService.title;
      request.fields['price'] = subService.price.toString();

      // Add the image file
      String fileExtension =
          path.extension(businessImage.path).replaceAll('.', '');
      var imageStream = http.ByteStream(businessImage.openRead());
      var length = await businessImage.length();

      var multipartFile = http.MultipartFile(
        'subServiceImages',
        imageStream,
        length,
        filename: path.basename(businessImage.path),
        contentType: MediaType('image', fileExtension),
      );

      request.files.add(multipartFile);

      // Send the request
      log('Sending business profile creation request to: $url');
      log('Request fields: ${request.fields}');

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      log('Response status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'msg': responseBody['msg'] ?? 'Subservice created successfully',
          'status': response.statusCode,
          'data': responseBody['data'] ?? {},
        };
      } else {
        return {
          'success': false,
          'msg': responseBody['msg'] ?? 'Failed to create Subservice',
          'status': response.statusCode,
          'data': {},
        };
      }
    } catch (e) {
      log('Error creating business profile: $e');
      return {
        'success': false,
        'msg':
            'An error occurred while creating Subservice. Please try again later.',
        'status': 500,
        'data': {},
      };
    }
  }

  Future<List<SubServiceSalon>> fetchSubServicesByServiceID(
    String serviceId,
  ) async {
    final Uri url = Uri.parse(
        '$kBaseUrl/api/admin/getSubServicesByServiceId?serviceId=$serviceId');
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
          List<SubServiceSalon> services = List<SubServiceSalon>.from(
            responseBody['data'].map((x) => SubServiceSalon.fromJson(x)),
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

  Future<List<SubServiceSalon>> fetchSubServicesByAdminID() async {
    final Uri url = Uri.parse('$kBaseUrl/api/admin/getSubServicesByAdminId');
    try {
      log('Fetching all salons from: $url');

      String token = await UserSession().getUserToken();

      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      log(token);
      log('Response status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['sucess']) {
          List<SubServiceSalon> services = List<SubServiceSalon>.from(
            responseBody['data'].map((x) => SubServiceSalon.fromJson(x)),
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

  Future<List<BusinessDataAdmin>> fetchAllSalons() async {
    final Uri url = Uri.parse('$kBaseUrl/api/admin/allBusinessProfiles');
    try {
      log('Fetching all salons from: $url');

      String token = await UserSession().getUserToken();

      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      log(token);
      log('Response status code: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['success']) {
          List<BusinessDataAdmin> bussiness = List<BusinessDataAdmin>.from(
            responseBody['data'].map((x) => BusinessDataAdmin.fromJson(x)),
          );
          return bussiness;
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
