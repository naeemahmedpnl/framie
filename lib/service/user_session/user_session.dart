import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.model.dart';

class UserSession {
  static final UserSession _instance = UserSession._internal();
  UserSession._internal();
  factory UserSession() => _instance;

  static Rx<UserModel> userModel = UserModel.empty().obs;

  Future<bool> isLoggedIn() async {
    UserModel user = await getUser();
    log(user.email.toString());
    log(user.phNumber.toString());
    log('User Type: ${user.userType.toString()} ');
    log('User id: ${user.id.toString()} ');
    log('User name: ${user.name.toString()} ');
    return user.email!.isNotEmpty;
  }

  Future<UserModel> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userModel.value = UserModel.fromJson(
      jsonDecode(
        prefs.getString('userModel') ?? "{}",
      ),
    );

    return userModel.value;
  }

  Future<void> saveUser(UserModel user) async {
    userModel.value = user;
    final preference = await SharedPreferences.getInstance();
    log('Session Creted: $user ');
    preference.setString(
      'userModel',
      jsonEncode(userModel.value.toJsonForSession()),
    );
  }

  Future<void> saveTokenUser(String token) async {
    final preference = await SharedPreferences.getInstance();
    log('Session Creted: $token ');
    preference.setString('token', token);
  }

  Future<String> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String toke = prefs.getString('token')!;
    return toke;
  }

  Future<void> saveUserType(bool token) async {
    final preference = await SharedPreferences.getInstance();
    log('Session Creted: $token ');
    preference.setBool('isAdmin', token);
  }

  Future<bool> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? toke = prefs.getBool('isAdmin');
    return toke ?? false;
  }

  Future<void> saveBussinessProfileValue(bool token) async {
    final preference = await SharedPreferences.getInstance();
    log('Session Creted: $token ');
    preference.setBool('bussinessProfile', token);
  }

  Future<bool> getBussinessProfileValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? toke = prefs.getBool('bussinessProfile');
    return toke ?? false;
  }

  Future<bool> removeUser() async {
    userModel.value = UserModel.empty();
    return (await SharedPreferences.getInstance()).clear();
  }
}
