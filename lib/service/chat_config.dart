// lib/service/chat_config.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

/// Configuration class for the chat system
class ChatConfig {
  /// Initialize Firebase for chat functionality
  static Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      log('Firebase initialized successfully');
      
      // Set Firestore settings
      FirebaseFirestore.instance.settings = Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );
      
      // Configure Storage
      FirebaseStorage.instance.setMaxUploadRetryTime(Duration(seconds: 15));
      FirebaseStorage.instance.setMaxDownloadRetryTime(Duration(seconds: 15));
      
      log('Firebase chat services configured');
    } catch (e) {
      log('Error initializing Firebase: $e');
      // Re-throw to allow calling code to handle the error
      rethrow;
    }
  }
  
  /// Default chat message styling constants
  static const Color userBubbleColor = Colors.blue;
  static const Color adminBubbleColor = Color(0xFFE0E0E0);
  static const Color userTextColor = Colors.white;
  static const Color adminTextColor = Colors.black87;
  static const double maxBubbleWidth = 0.7; // 70% of screen width
  
  /// Firebase collection paths
  static const String usersCollection = 'users';
  static const String adminsCollection = 'admins';
  static const String chatsCollection = 'chats';
  static const String messagesSubcollection = 'messages';
  static const String userChatsCollection = 'user_chats';
  static const String adminChatsCollection = 'admin_chats';
  
  /// Storage paths
  static const String chatImagesPath = 'chat_images';
  static const String chatFilesPath = 'chat_files';
  
  /// Chat image quality settings
  static const int imageQuality = 70; // 70% quality for uploads
  static const double thumbnailSize = 200.0; // 200px for thumbnails
  
  /// Chat session timeout in minutes
  static const int chatSessionTimeout = 60; // 1 hour
  
  /// Maximum file upload size in bytes (5MB)
  static const int maxFileSize = 5 * 1024 * 1024;
  
  /// Message types
  static const String messageTypeText = 'text';
  static const String messageTypeImage = 'image';
  static const String messageTypeFile = 'file';
  
  /// Chat status options
  static const String chatStatusActive = 'active';
  static const String chatStatusClosed = 'closed';
  static const String chatStatusArchived = 'archived';
}