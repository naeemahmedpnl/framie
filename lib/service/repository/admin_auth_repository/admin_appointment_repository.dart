import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:beauty/service/user_session/user_session.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

import '../../../models/admin_models/create_employee_model.dart';
import '../../../models/appointment_model.dart';
import '../../service_constants/configs.dart';

class AdminAppointmentRepositoryUser {
  Future<List<AppointmentData>> fetchAllEmployees() async {
    String userId = UserSession.userModel.value.id.toString();
    final Uri url = Uri.parse(
      '$kBaseUrl/api/admin/getAppointmentByAdmin?adminId=$userId',
    );
    try {
      log('Fetching all salons from: $url');

      final response = await http.get(
        url,
      );

      log('Response status code: ${response.statusCode}');
      log('Response body: ${response.body}');
      log('$kBaseUrl/api/admin/getAppointmentsByUser?userId=$userId');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['success']) {
          List<AppointmentData> services = (responseBody['data']
                  as List<dynamic>)
              .map((x) => AppointmentData.fromJson(x as Map<String, dynamic>))
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

  Future<Map<String, dynamic>> updateAppointment({
    required String appointmentId,
    required String status,
  }) async {
    final Uri url = Uri.parse('$kBaseUrl/api/admin/updateAppointment');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "appointmentId": appointmentId,
          "status": status,
        }),
      );

      final Map<String, dynamic> responseBody = json.decode(response.body);
      log('Response Body: $responseBody');

      if (responseBody['success'] == true) {
        return {
          'success': true,
          'msg': responseBody['msg'],
          'status': response.statusCode,
          'data': responseBody['data'] ?? {},
        };
      } else {
        return {
          'success': false,
          'msg': responseBody['msg'],
          'status': response.statusCode,
          'data': {},
        };
      }
    } catch (e) {
      log('Error: $e');
      return {
        'success': false,
        'msg': 'An error occurred. Please try again later.',
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
            'An error occurred while creating Employee profile. Please try again later.',
        'status': 500,
        'data': {},
      };
    }
  }
}
