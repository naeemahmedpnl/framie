import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '/service/user_session/user_session.dart';
import '../../views/auth/otp/otp_screen.dart';
import '../service_constants/configs.dart';

class AuthRepository {
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    final Uri url = Uri.parse(kLoginUrl);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      log('Body:- Email $email , Password $password ');

      final Map<String, dynamic> responseBody = json.decode(response.body);

      log(responseBody.toString());
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
      return {
        'success': false,
        'msg': 'An error occurred. Please try again.',
        'status': 500,
        'data': {},
      };
    }
  }

  Future<Map<String, dynamic>> registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phNumber,
    required String city,
  }) async {
    final Uri url = Uri.parse(kRegisterUrl);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "firstName": firstName,
          "lastName": lastName,
          "phNumber": phNumber,
          "city": city,
          "email": email,
          "password": password,
        }),
      );

      log('Request Body: Email: $email, Password: $password');
      final Map<String, dynamic> responseBody = json.decode(response.body);
      log('Response Body: $responseBody');

      if (responseBody['success'] == true) {
        log(responseBody['data']['id']);
        Get.to(
          () => OTPVerificationScreen(
            otp: responseBody['data']['OTP'],
            userId: responseBody['data']['id'],
            email: email,
          ),
        );
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

  Future<Map<String, dynamic>> updateUserAccount({
    required String firstName,
    required String lastName,
    required String phNumber,
    required String city,
  }) async {
    var finalUrl = '';

    if (await UserSession().getUserType() == true) {
      finalUrl = '$kBaseUrl/api/admin/updateAdmin';
    } else {
      finalUrl = '$kBaseUrl/api/user/updateProfie';
    }

    final Uri url = Uri.parse(finalUrl);

    log(finalUrl);

    try {
      log("firstName $firstName lastName $lastName phNumber $phNumber city $city");

      String token = await UserSession().getUserToken();
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "firstName": firstName,
          "lastName": lastName,
          "phNumber": phNumber,
          "city": city,
        }),
      );

      final Map<String, dynamic> responseBody = json.decode(response.body);
      log('Response Body: $responseBody');

      if (responseBody['sucess'] == true) {
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

  Future<Map<String, dynamic>> verifyOTP({
    required String email,
    required String otp,
  }) async {
    final Uri url = Uri.parse(kVerifyOTPUrl);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "email": email,
          "OTP": otp,
        }),
      );

      log('Request Body: Email: $email, otp: $otp');
      final Map<String, dynamic> responseBody = json.decode(response.body);
      log('Response Body: $responseBody');

      if (responseBody['success'] == true) {
        String accessToken = responseBody['accessToken'];
        UserSession().saveTokenUser(accessToken);
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

  Future<Map<String, dynamic>> resendOTP({
    required String userId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(kGenerateOTPUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"userId": userId}),
      );
      log(response.body.toString());

      log('Request Body: userId: $userId, ');
      final Map<String, dynamic> responseBody = json.decode(response.body);
      log('Response Body: $responseBody');

      if (responseBody['success'] == true) {
        final response = await http.post(
          Uri.parse(kGenerateOTPUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({"userId": responseBody['data']['id']}),
        );
        log(response.body.toString());

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
}
