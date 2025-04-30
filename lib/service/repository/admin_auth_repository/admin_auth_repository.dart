import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:beauty/models/user.model.dart';
import 'package:beauty/service/user_session/user_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

      // Check for both 'success' and 'sucess' keys to handle API typo
      bool isSuccess =
          responseBody['success'] == true || responseBody['sucess'] == true;

      if (isSuccess) {
        // Handle both 'accessToken' and 'aceessToken' keys to handle API typo
        String token =
            responseBody['accessToken'] ?? responseBody['aceessToken'] ?? '';

        if (token.isNotEmpty) {
          UserSession().saveTokenUser(token);
        }

        return {
          'success': true,
          'msg': responseBody['msg'],
          'status': response.statusCode,
          'data': responseBody['data'] ?? {},
          'accessToken': token,
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
      log('Error in signIn: $e');
      return {
        'success': false,
        'msg': 'An error occurred. Please try again.',
        'status': 500,
        'data': {},
        'accessToken': '',
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

      // Check for both 'success' and 'sucess' keys to handle API typo
       if (response.statusCode == 200 && responseBody['success'] == true) {
    // Extract token with the correct key name "accessToke"
    String token = responseBody['accessToke'] ?? '';
    
    if (token.isNotEmpty) {
      log('Saving token: $token');
      await UserSession().saveTokenUser(token);
    } else {
      log('Warning: No token found in response');
    }
    
    return {
      'success': true,
      'msg': responseBody['msg'],
      'status': response.statusCode,
      'data': responseBody['data'] ?? {},
      'accessToken': token, 
    };
      // bool isSuccess = response.statusCode == 200 &&
      //     (responseBody['success'] == true || responseBody['sucess'] == true);

      // if (isSuccess) {
      //   // Handle both 'accessToken' and 'aceessToken' keys to handle API typo
      //   String token =
      //       responseBody['accessToken'] ?? responseBody['aceessToken'] ?? '';

      //   if (token.isNotEmpty) {
      //     await UserSession().saveTokenUser(token);
      //   }

      //   return {
      //     'success': true,
      //     'msg': responseBody['msg'],
      //     'status': response.statusCode,
      //     'data': responseBody['data'] ?? {},
      //     'accessToken': token,
      //   };
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
      log('Error in registerAdmin: $e');
      return {
        'success': false,
        'msg': 'An error occurred. Please try again later.',
        'status': 500,
        'data': {},
        'accessToken': '',
      };
    }
  }

// Modified function to sync admin data to Firebase with better error handling
  Future<bool> syncAdminToFirebase(UserModel admin, String token) async {
    try {
      if (admin.id.isEmpty) {
        log('Error: Admin ID is empty');
        return false;
      }

      if (token.isEmpty) {
        log('Error: Token is empty');
        return false;
      }

      String adminId = admin.id;

      // Create admin data map with all needed fields
      Map<String, dynamic> adminData = {
        'uid': adminId,
        'userName': '${admin.name ?? ''}'.trim(),
        'email': admin.email ?? '',
        'phone': admin.phNumber?.toString() ?? '',
        'city': admin.city ?? '',
        'isVerified': true,
        'online': true,
        'last_active': FieldValue.serverTimestamp(),
        'node_jwt': token,
        'photo_url': admin.profile ?? '',
        'is_admin': true, // Flag to identify as admin
        'lastSync': DateTime.now().toString(),
      };

      // Track overall success
      bool adminsSuccess = false;
      bool usersSuccess = false;

      // Try writing to admins collection with error handling
      try {
        await FirebaseFirestore.instance
            .collection('admins')
            .doc(adminId)
            .set(adminData, SetOptions(merge: true));

        log('Admin data written to admins collection successfully');
        adminsSuccess = true;
      } catch (e) {
        log('Error writing to admins collection: $e');
        // Continue to try writing to users collection
      }

      // Delay briefly before the second write to avoid rate limiting
      await Future.delayed(Duration(milliseconds: 500));

      // Try writing to users collection with error handling
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(adminId)
            .set(adminData, SetOptions(merge: true));

        log('Admin data written to users collection successfully');
        usersSuccess = true;
      } catch (e) {
        log('Error writing to users collection: $e');
      }

      // Return true if at least one write was successful
      return adminsSuccess || usersSuccess;
    } catch (e) {
      log('Error in Firebase admin sync: $e');
      return false;
    }
  }
}
