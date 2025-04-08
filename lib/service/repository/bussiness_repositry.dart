import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

import '../../models/bussiness_profile_admin.dart';
import '../../models/bussiness_profile_model.dart';
import '../service_constants/configs.dart';
import '../user_session/user_session.dart';

class BussinessRepository {
  Future<Map<String, dynamic>> createBussinessProfile({
    required BusinessProfile profile,
    required File businessImage,
  }) async {
    final Uri url = Uri.parse('$kBaseUrl/api/admin/addBusinessProfile');

    try {
      // Create a multipart request
      var request = http.MultipartRequest('POST', url);

      String? token = await UserSession().getUserToken();

      request.headers['Authorization'] = 'Bearer $token';

      // Add text fields
      request.fields['adminId'] = profile.adminId;
      request.fields['businessName'] = profile.businessName;
      request.fields['userName'] = profile.userName;
      request.fields['city'] = profile.city;
      request.fields['address'] = profile.address;

      // For arrays, we need to encode them as JSON strings
      request.fields['availableServices'] =
          jsonEncode(profile.availableServices);
      request.fields['workingDays'] =
          jsonEncode(profile.workingDays.map((day) => day.toJson()).toList());

      // Add the image file
      String fileExtension =
          path.extension(businessImage.path).replaceAll('.', '');
      var imageStream = http.ByteStream(businessImage.openRead());
      var length = await businessImage.length();

      var multipartFile = http.MultipartFile(
        'BusinessImage',
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
          'msg': responseBody['msg'] ?? 'Business profile created successfully',
          'status': response.statusCode,
          'data': responseBody['data'] ?? {},
        };
      } else {
        return {
          'success': false,
          'msg': responseBody['msg'] ?? 'Failed to create business profile',
          'status': response.statusCode,
          'data': {},
        };
      }
    } catch (e) {
      log('Error creating business profile: $e');
      return {
        'success': false,
        'msg':
            'An error occurred while creating business profile. Please try again later.',
        'status': 500,
        'data': {},
      };
    }
  }

  Future<Map<String, dynamic>> updateBussinessProfile({
    required BusinessProfile profile,
    required File businessImage,
  }) async {
    final Uri url = Uri.parse('$kBaseUrl/api/admin/updateBusinessProfile');

    try {
      // Create a multipart request
      var request = http.MultipartRequest('POST', url);

      String? token = await UserSession().getUserToken();

      request.headers['Authorization'] = 'Bearer $token';

      // Add text fields
      request.fields['adminId'] = profile.adminId;
      request.fields['businessName'] = profile.businessName;
      request.fields['userName'] = profile.userName;
      request.fields['city'] = profile.city;
      request.fields['address'] = profile.address;

      // For arrays, we need to encode them as JSON strings
      request.fields['availableServices'] =
          jsonEncode(profile.availableServices);
      request.fields['workingDays'] =
          jsonEncode(profile.workingDays.map((day) => day.toJson()).toList());

      // Add the image file
      String fileExtension =
          path.extension(businessImage.path).replaceAll('.', '');
      var imageStream = http.ByteStream(businessImage.openRead());
      var length = await businessImage.length();

      var multipartFile = http.MultipartFile(
        'BusinessImage',
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
          'msg': responseBody['msg'] ?? 'Business profile created successfully',
          'status': response.statusCode,
          'data': responseBody['data'] ?? {},
        };
      } else {
        return {
          'success': false,
          'msg': responseBody['msg'] ?? 'Failed to create business profile',
          'status': response.statusCode,
          'data': {},
        };
      }
    } catch (e) {
      log('Error creating business profile: $e');
      return {
        'success': false,
        'msg':
            'An error occurred while creating business profile. Please try again later.',
        'status': 500,
        'data': {},
      };
    }
  }

  Future<BusinessDataAdmin?> fetchBussinessAdminToken() async {
    final Uri url = Uri.parse('$kBaseUrl/api/admin/getBusinessProfile');
    try {
      log('Fetching Business Profile from: $url');

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
          BusinessDataAdmin business =
              BusinessDataAdmin.fromJson(responseBody['data']);
          return business;
        } else {
          log('Failed to fetch business: ${responseBody['msg']}');
          return null;
        }
      } else {
        log('Failed to fetch business: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      log('Error fetching business: $e');
      return null;
    }
  }
}
