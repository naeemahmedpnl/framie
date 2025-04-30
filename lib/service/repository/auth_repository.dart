import 'dart:convert';
import 'dart:developer';
import 'package:beauty/models/user.model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '/service/user_session/user_session.dart';
import '../../views/auth/otp/otp_screen.dart';
import '../service_constants/configs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AuthRepository {
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

  // Updated signUpWithGoogle method
Future<Map<String, dynamic>> signUpWithGoogle(Map<String, dynamic> userData) async {
  final Uri url = Uri.parse(kSignInWithGoogle);
  
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userData),
    );
    
    log('Request Body: ${userData.toString()}');
    final Map<String, dynamic> responseBody = json.decode(response.body);
    log('Response Body: $responseBody');
    
    if (responseBody['success'] == true) {
      // Save token from backend
      String accessToken = responseBody['accessToken'];
      await UserSession().saveTokenUser(accessToken);
      
      // Get user data
      final userData = responseBody['data'];
      
      // Create and sync user to Firebase
      if (userData != null) {
        // Parse phone number safely, ensuring it's an integer
        int? phoneNumber;
        if (userData['phNumber'] != null) {
          try {
            if (userData['phNumber'] is String) {
              // Try to parse string to int
              phoneNumber = int.tryParse(userData['phNumber']);
            } else if (userData['phNumber'] is int) {
              // It's already an int
              phoneNumber = userData['phNumber'];
            }
          } catch (e) {
            log('Error parsing phone number: $e');
            phoneNumber = 0; // Default value on error
          }
        }
        
        final userModel = UserModel(
          id: userData['_id'] ?? '',
          name: '${userData['firstName'] ?? ''} ${userData['lastName'] ?? ''}'.trim(),
          email: userData['email'] ?? '',
          phNumber: phoneNumber, // Safely parsed phone number
          city: userData['city'] ?? '',
          isVerified: true,
          profile: userData['profile'] ?? '',
        );
        
        // Sync with Firebase in the background
        try {
          syncUserToFirebaseSimple(userModel, accessToken);
        } catch (syncError) {
          log('Firebase sync exception: $syncError');
          // Continue even if sync fails
        }
      }
      
      return {
        'success': true,
        'msg': responseBody['msg'],
        'status': response.statusCode,
        'data': userData,
        'accessToken': accessToken,
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
    log('Error in signUpWithGoogle: $e');
    return {
      'success': false,
      'msg': 'An error occurred. Please try again later.',
      'status': 500,
      'data': {},
    };
  }
}



  Future<bool> syncUserToFirebaseSimple(UserModel user, String token) async {
  try {
    // Skip Firebase Auth since it's failing
    String userId = user.id;
    
    // Try direct write to Firestore without authentication
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'uid': userId,
      'userName': '${user.name ?? ''}'.trim(),
      'email': user.email ?? '',
      'phone': user.phNumber?.toString() ?? '',
      'city': user.city ?? '',
      'isVerified': true,
      'online': true,
      'last_active': FieldValue.serverTimestamp(),
      'node_jwt': token, 
      'photo_url': user.profile ?? '', 
      'lastSync': DateTime.now().toString(),
    }, SetOptions(merge: true));
    
    log('User data written to Firebase successfully');
    return true;
  } catch (e) {
    log('Error in Firebase sync: $e');
    return false;
  }
}

  Future<Map<String, dynamic>> verifyOTP({
  required String email,
  required String otp,
}) async {
  final Uri url = Uri.parse(kVerifyOTPUrl);
  try {
    // 1. Call backend API
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
      // 2. Save token from your backend
      String accessToken = responseBody['accessToken'];
      await UserSession().saveTokenUser(accessToken);
      
      // 3. Create user model from response data
      final userData = responseBody['data'];
      if (userData == null) {
        log('Warning: User data is null in API response');
        return {
          'success': false,
          'msg': 'Invalid user data received from server',
          'status': response.statusCode,
          'data': {},
        };
      }
      
      // 4. Create robust user model
      final userModel = UserModel(
        id: userData['_id'] ?? '',
        name: '${userData['firstName'] ?? ''} ${userData['lastName'] ?? ''}'.trim(),
        email: userData['email'] ?? '',
        phNumber: userData['phNumber'] ?? '',
        city: userData['city'] ?? '',
        isVerified: true,
        profile: userData['profile'] ?? '',
      );
      
      // 5. Sync user data to Firebase with better error handling
      bool syncSuccess = false;
      try {
        

        syncSuccess = await syncUserToFirebaseSimple(userModel, accessToken);
        log('Firebase sync result: ${syncSuccess ? "Success" : "Failed"}');
      } catch (syncError) {
        log('Firebase sync exception: $syncError');
        // Continue with the flow even if sync fails
      }
      
      // 6. Save user model locally for offline access
      await UserSession().saveUserData(userModel);
      
      return {
        'success': true,
        'firebase_sync': syncSuccess,
        'msg': responseBody['msg'],
        'status': response.statusCode,
        'data': userData,
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
