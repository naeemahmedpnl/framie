import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:beauty/models/admin_models/all_employees_model.dart';
import 'package:beauty/service/user_session/user_session.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

import '../../models/admin_models/create_employee_model.dart';
import '../service_constants/configs.dart';

class AllEmployeesRepository {
  Future<List<AllEmployees>> fetchAllEmployees(String adminId) async {
    final Uri url =
        Uri.parse('$kBaseUrl/api/admin/getAllEmployees?adminId=$adminId');
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
          List<AllEmployees> services = (responseBody['data'] as List<dynamic>)
              .map((x) => AllEmployees.fromJson(x as Map<String, dynamic>))
              .toList();

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

  Future<Map<String, dynamic>> addEmployeeProfile({
    required CreateAllEmployees profile,
    required File businessImage,
  }) async {
    final Uri url = Uri.parse('$kBaseUrl/api/admin/addEmployee');

    try {
      // Create a multipart request
      var request = http.MultipartRequest('POST', url);

      String? token = await UserSession().getUserToken();

      request.headers['Authorization'] = 'Bearer $token';
      // Add text fields
      request.fields['createdBy'] = UserSession.userModel.value.id;
      request.fields['employeeName'] = profile.employeeName;
      request.fields['about'] = profile.about;

      // For arrays, we need to encode them as JSON strings
      request.fields['availableServices'] =
          jsonEncode(profile.availableServices);
      request.fields['workingDays'] =
          jsonEncode(profile.workingDays.map((day) => day.toJson()).toList());

      log(profile.workingDays.map((day) => day.toJson()).toList().toString());
      // Add the image file
      String fileExtension =
          path.extension(businessImage.path).replaceAll('.', '');
      var imageStream = http.ByteStream(businessImage.openRead());
      var length = await businessImage.length();

      var multipartFile = http.MultipartFile(
        'EmployeeImage',
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
          'msg': responseBody['msg'] ?? 'Employee profile created successfully',
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

  Future<Map<String, dynamic>> updateEmployeeProfile({
    required CreateAllEmployees profile,
    required File businessImage,
  }) async {
    final Uri url = Uri.parse('$kBaseUrl/api/admin/updateEmployee');

    try {
      // Create a multipart request
      var request = http.MultipartRequest('POST', url);

      String? token = await UserSession().getUserToken();

      request.headers['Authorization'] = 'Bearer $token';
      // Add text fields
      request.fields['createdBy'] = UserSession.userModel.value.id;
      request.fields['employeeName'] = profile.employeeName;
      request.fields['about'] = profile.about;

      // For arrays, we need to encode them as JSON strings
      request.fields['availableServices'] =
          jsonEncode(profile.availableServices);
      request.fields['workingDays'] =
          jsonEncode(profile.workingDays.map((day) => day.toJson()).toList());

      log(profile.workingDays.map((day) => day.toJson()).toList().toString());
      // Add the image file
      String fileExtension =
          path.extension(businessImage.path).replaceAll('.', '');
      var imageStream = http.ByteStream(businessImage.openRead());
      var length = await businessImage.length();

      var multipartFile = http.MultipartFile(
        'EmployeeImage',
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
          'msg': responseBody['msg'] ?? 'Employee profile created successfully',
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
}
