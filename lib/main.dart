import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
 
  
  try {
    await Firebase.initializeApp();
    log('Firebase initialized successfully');
  } catch (e) {
    log('Firebase initialization error: $e');
    // Continue with app initialization even if Firebase fails
  }
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const App());
}
