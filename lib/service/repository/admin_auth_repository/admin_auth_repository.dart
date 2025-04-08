import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:beauty/service/user_session/user_session.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

import '/service/service_constants/configs.dart';

class AdminAuthRepository {
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    final Uri url = Uri.parse(kAdminLoginUrl);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      log('Body:- Email $email , Password $password ');

      final Map<String, dynamic> responseBody = json.decode(response.body);

      log(responseBody.toString());
      if (responseBody['data'] != {}) {
        String token = responseBody['aceessToken'];
        UserSession().saveTokenUser(token);
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
      return {
        'success': false,
        'msg': 'An error occurred. Please try again.',
        'status': 500,
        'data': {},
      };
    }
  }

  Future<Map<String, dynamic>> registerAdmin({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phNumber,
    required String city,
    required File businessImage,
  }) async {
    final Uri url = Uri.parse(kAdminRegisterUrl);

    try {
      var request = http.MultipartRequest("POST", url);
      request.headers.addAll({'Content-Type': 'multipart/form-data'});

      request.fields['firstName'] = firstName;
      request.fields['lastName'] = lastName;
      request.fields['phNumber'] = phNumber;
      request.fields['city'] = city;
      request.fields['email'] = email;
      request.fields['password'] = password;

      // Add the image file
      String fileExtension =
          path.extension(businessImage.path).replaceAll('.', '');
      var imageStream = http.ByteStream(businessImage.openRead());
      var length = await businessImage.length();

      var multipartFile = http.MultipartFile(
        'AdminImage',
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

      if (response.statusCode == 200 && responseBody['success'] == true) {
        return {
          'success': true,
          'msg': responseBody['msg'],
          'status': response.statusCode,
          'data': responseBody['data'] ?? {},
          'accessToken': responseBody['accessToke'],
        };
      } else {
        return {
          'success': false,
          'msg': responseBody['msg'],
          'status': response.statusCode,
          'data': {},
          'accessToken': '',
        };
      }
    } catch (e) {
      log('Error: $e');
      return {
        'success': false,
        'msg': 'An error occurred. Please try again later.',
        'status': 500,
        'data': {},
        'accessToken': '',
      };
    }
  }
}
