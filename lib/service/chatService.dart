
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:beauty/models/user.model.dart';
import 'package:beauty/service/user_session/user_session.dart';
import 'dart:developer';
import 'package:uuid/uuid.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  
  // Get current user information
  Future<UserModel> _getCurrentUser() async {
    return await UserSession().getUser();
  }
  
  // Check if user is admin
  Future<bool> isUserAdmin() async {
    bool isAdmin = await UserSession().getUserType();
    return isAdmin;
  }
  
  // Create a new chat between user and admin
  Future<String> createChat(String otherUserId) async {
    try {
      UserModel currentUser = await _getCurrentUser();
      bool isAdmin = await isUserAdmin();
      
      String userId = isAdmin ? otherUserId : currentUser.id;
      String adminId = isAdmin ? currentUser.id : otherUserId;
      
      // Check if a chat already exists
      QuerySnapshot existingChats = await _firestore
          .collection('chats')
          .where('user_id', isEqualTo: userId)
          .where('admin_id', isEqualTo: adminId)
          .limit(1)
          .get();
      
      if (existingChats.docs.isNotEmpty) {
        return existingChats.docs.first.id;
      }
      
      // Create new chat
      DocumentReference chatRef = await _firestore.collection('chats').add({
        'user_id': userId,
        'admin_id': adminId,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
        'last_message': '',
        'last_message_time': FieldValue.serverTimestamp(),
        'unread_user': 0,
        'unread_admin': 0,
        'status': 'active',
      });
      
      // Get user and admin details
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
      DocumentSnapshot adminDoc = await _firestore.collection('admins').doc(adminId).get();
      
      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
      Map<String, dynamic>? adminData = adminDoc.data() as Map<String, dynamic>?;
      
      // Create entry in user_chats
      await _firestore.collection('user_chats').doc(userId).collection('chats').doc(chatRef.id).set({
        'chat_id': chatRef.id,
        'admin_id': adminId,
        'admin_name': adminData?['userName'] ?? 'Admin',
        'admin_photo': adminData?['photo_url'] ?? '',
        'last_message': '',
        'last_message_time': FieldValue.serverTimestamp(),
        'unread_count': 0,
      });
      
      // Create entry in admin_chats
      await _firestore.collection('admin_chats').doc(adminId).collection('chats').doc(chatRef.id).set({
        'chat_id': chatRef.id,
        'user_id': userId,
        'user_name': userData?['userName'] ?? 'User',
        'user_photo': userData?['photo_url'] ?? '',
        'last_message': '',
        'last_message_time': FieldValue.serverTimestamp(),
        'unread_count': 0,
      });
      
      return chatRef.id;
    } catch (e) {
      log('Error creating chat: $e');
      throw e;
    }
  }
  
  // Send a text message
  Future<void> sendMessage(String chatId, String content) async {
    try {
      UserModel currentUser = await _getCurrentUser();
      bool isAdmin = await isUserAdmin();
      
      String senderId = currentUser.id;
      String senderType = isAdmin ? 'admin' : 'user';
      String recipientType = isAdmin ? 'user' : 'admin';
      
      // Add message to the chat
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
        'sender_id': senderId,
        'sender_type': senderType,
        'content': content,
        'timestamp': FieldValue.serverTimestamp(),
        'read': false,
        'type': 'text',
      });
      
      // Update chat document
      await _firestore.collection('chats').doc(chatId).update({
        'last_message': content,
        'last_message_time': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
        'unread_${recipientType}': FieldValue.increment(1),
      });
      
      // Get chat data
      DocumentSnapshot chatDoc = await _firestore.collection('chats').doc(chatId).get();
      Map<String, dynamic> chatData = chatDoc.data() as Map<String, dynamic>;
      
      // Update user chats
      String userId = chatData['user_id'];
      await _firestore
          .collection('user_chats')
          .doc(userId)
          .collection('chats')
          .doc(chatId)
          .update({
        'last_message': content,
        'last_message_time': FieldValue.serverTimestamp(),
        'unread_count': isAdmin ? FieldValue.increment(1) : 0,
      });
      
      // Update admin chats
      String adminId = chatData['admin_id'];
      await _firestore
          .collection('admin_chats')
          .doc(adminId)
          .collection('chats')
          .doc(chatId)
          .update({
        'last_message': content,
        'last_message_time': FieldValue.serverTimestamp(),
        'unread_count': !isAdmin ? FieldValue.increment(1) : 0,
      });
    } catch (e) {
      log('Error sending message: $e');
      throw e;
    }
  }
  


  // Send image message
Future<void> sendImageMessage(String chatId, File imageFile) async {
  try {
    UserModel currentUser = await _getCurrentUser();
    bool isAdmin = await isUserAdmin();
    
    String senderId = currentUser.id;
    String senderType = isAdmin ? 'admin' : 'user';
    String recipientType = isAdmin ? 'user' : 'admin';
    
    // Generate unique filename
    String fileName = '${DateTime.now().millisecondsSinceEpoch}_${Uuid().v4()}.jpg';
    
    log('Attempting to upload file: $fileName');
    log('File exists: ${imageFile.existsSync()}');
    log('File size: ${await imageFile.length()} bytes');
    
    // Create reference to root first
    final storageRef = FirebaseStorage.instance.ref();
    
    try {
      // Create references for the chat_images directory and file
      final fileRef = storageRef.child('chat_images/$fileName');
      
      // Upload file with metadata
      UploadTask uploadTask = fileRef.putFile(
        imageFile,
        SettableMetadata(
          contentType: 'image/jpeg',
        ),
      );
      
      // Monitor upload progress
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        log('Upload progress: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
      });
      
      // Wait for upload to complete
      TaskSnapshot snapshot = await uploadTask;
      log('Upload complete');
      
      // Get download URL
      String imageUrl = await snapshot.ref.getDownloadURL();
      log('Download URL: $imageUrl');
      
      // Add message to the chat
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
        'sender_id': senderId,
        'sender_type': senderType,
        'content': 'Image',
        'timestamp': FieldValue.serverTimestamp(),
        'read': false,
        'type': 'image',
        'file_url': imageUrl,
      });
      
      // Update chat document
      await _firestore.collection('chats').doc(chatId).update({
        'last_message': 'Image',
        'last_message_time': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
        'unread_${recipientType}': FieldValue.increment(1),
      });
      
      // Get chat data
      DocumentSnapshot chatDoc = await _firestore.collection('chats').doc(chatId).get();
      Map<String, dynamic> chatData = chatDoc.data() as Map<String, dynamic>;
      
      // Update user chats
      String userId = chatData['user_id'];
      await _firestore
          .collection('user_chats')
          .doc(userId)
          .collection('chats')
          .doc(chatId)
          .update({
        'last_message': 'Image',
        'last_message_time': FieldValue.serverTimestamp(),
        'unread_count': isAdmin ? FieldValue.increment(1) : 0,
      });
      
      // Update admin chats
      String adminId = chatData['admin_id'];
      await _firestore
          .collection('admin_chats')
          .doc(adminId)
          .collection('chats')
          .doc(chatId)
          .update({
        'last_message': 'Image',
        'last_message_time': FieldValue.serverTimestamp(),
        'unread_count': !isAdmin ? FieldValue.increment(1) : 0,
      });
      
    } catch (storageError) {
      log('Storage specific error: $storageError');
      
      // Fallback to root upload if the directory doesn't exist
      final rootFileRef = storageRef.child(fileName);
      
      log('Attempting fallback upload to root directory');
      TaskSnapshot rootUploadTask = await rootFileRef.putFile(imageFile);
      String imageUrl = await rootUploadTask.ref.getDownloadURL();
      
      log('Fallback upload successful, URL: $imageUrl');
      
      // Add message to the chat
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
        'sender_id': senderId,
        'sender_type': senderType,
        'content': 'Image',
        'timestamp': FieldValue.serverTimestamp(),
        'read': false,
        'type': 'image',
        'file_url': imageUrl,
      });
      
      // Update chat document
      await _firestore.collection('chats').doc(chatId).update({
        'last_message': 'Image',
        'last_message_time': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
        'unread_${recipientType}': FieldValue.increment(1),
      });
      
      // Get chat data
      DocumentSnapshot chatDoc = await _firestore.collection('chats').doc(chatId).get();
      Map<String, dynamic> chatData = chatDoc.data() as Map<String, dynamic>;
      
      // Update user chats
      String userId = chatData['user_id'];
      await _firestore
          .collection('user_chats')
          .doc(userId)
          .collection('chats')
          .doc(chatId)
          .update({
        'last_message': 'Image',
        'last_message_time': FieldValue.serverTimestamp(),
        'unread_count': isAdmin ? FieldValue.increment(1) : 0,
      });
      
      // Update admin chats
      String adminId = chatData['admin_id'];
      await _firestore
          .collection('admin_chats')
          .doc(adminId)
          .collection('chats')
          .doc(chatId)
          .update({
        'last_message': 'Image',
        'last_message_time': FieldValue.serverTimestamp(),
        'unread_count': !isAdmin ? FieldValue.increment(1) : 0,
      });
    }
  } catch (e) {
    log('Error sending image: $e');
    throw e;
  }
}

  // Mark messages as read
  Future<void> markMessagesAsRead(String chatId) async {
    try {
      UserModel currentUser = await _getCurrentUser();
      bool isAdmin = await UserSession().getUserType();
      
      String currentUserType = isAdmin ? 'admin' : 'user';
      
      // Get unread messages not sent by current user
      QuerySnapshot unreadMessages = await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .where('read', isEqualTo: false)
          .where('sender_type', isNotEqualTo: currentUserType)
          .get();
      
      // Update each message
      WriteBatch batch = _firestore.batch();
      for (var doc in unreadMessages.docs) {
        batch.update(doc.reference, {'read': true});
      }
      
      await batch.commit();
      
      // Reset unread counter for current user type
      await _firestore.collection('chats').doc(chatId).update({
        'unread_$currentUserType': 0,
      });
      
      // Update the respective chat list
      DocumentSnapshot chatDoc = await _firestore.collection('chats').doc(chatId).get();
      Map<String, dynamic> chatData = chatDoc.data() as Map<String, dynamic>;
      
      if (isAdmin) {
        await _firestore
            .collection('admin_chats')
            .doc(currentUser.id)
            .collection('chats')
            .doc(chatId)
            .update({
          'unread_count': 0,
        });
      } else {
        await _firestore
            .collection('user_chats')
            .doc(currentUser.id)
            .collection('chats')
            .doc(chatId)
            .update({
          'unread_count': 0,
        });
      }
    } catch (e) {
      log('Error marking messages as read: $e');
      throw e;
    }
  }
  

Stream<QuerySnapshot> getChats() async* {
  try {
    UserModel currentUser = await _getCurrentUser();
    bool isAdmin = await isUserAdmin(); // Use consistent method
    
    log("ChatService.getChats - isAdmin: $isAdmin, userId: ${currentUser.id}");
    
    if (isAdmin) {
      yield* _firestore
          .collection('admin_chats')
          .doc(currentUser.id)
          .collection('chats')
          .orderBy('last_message_time', descending: true)
          .snapshots();
    } else {
      yield* _firestore
          .collection('user_chats')
          .doc(currentUser.id)
          .collection('chats')
          .orderBy('last_message_time', descending: true)
          .snapshots();
    }
  } catch (e) {
    log('Error getting chats: $e');
    // Return empty stream instead of throwing
    yield* Stream<QuerySnapshot>.empty();
  }
}


  // // Get chats for current user
  // Stream<QuerySnapshot> getChats() async* {
  //   try {
  //     UserModel currentUser = await _getCurrentUser();
  //     bool isAdmin = await UserSession().getUserType();
      
  //     if (isAdmin) {
  //       yield* _firestore
  //           .collection('admin_chats')
  //           .doc(currentUser.id)
  //           .collection('chats')
  //           .orderBy('last_message_time', descending: true)
  //           .snapshots();
  //     } else {
  //       yield* _firestore
  //           .collection('user_chats')
  //           .doc(currentUser.id)
  //           .collection('chats')
  //           .orderBy('last_message_time', descending: true)
  //           .snapshots();
  //     }
  //   } catch (e) {
  //     log('Error getting chats: $e');
  //     throw e;
  //   }
  // }
  
  // Get messages for a specific chat
  Stream<QuerySnapshot> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
  
  // Get available admins to chat with (for user)
  Future<List<UserModel>> getAvailableAdmins() async {
    try {
      QuerySnapshot adminDocs = await _firestore
          .collection('admins')
          .where('online', isEqualTo: true)
          .get();
      
      List<UserModel> admins = adminDocs.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return UserModel(
          id: doc.id,
          name: data['userName'] ?? '',
          email: data['email'] ?? '',
          phNumber: data['phone'] ?? '',
          city: data['city'] ?? '',
          profile: data['photo_url'] ?? '',
          isVerified: data['isVerified'] ?? false,
        );
      }).toList();
      
      return admins;
    } catch (e) {
      log('Error getting admins: $e');
      return [];
    }
  }
  

  // Add to ChatService class
Future<void> createTestChatIfEmpty() async {
  UserModel currentUser = await _getCurrentUser();
  bool isAdmin = await isUserAdmin();
  
  if (!isAdmin) return; // Only for admins
  
  var chats = await _firestore
      .collection('admin_chats')
      .doc(currentUser.id)
      .collection('chats')
      .get();
      
  if (chats.docs.isEmpty) {
    // Create a test chat entry
    String chatId = Uuid().v4();
    await _firestore
        .collection('admin_chats')
        .doc(currentUser.id)
        .collection('chats')
        .doc(chatId)
        .set({
      'chat_id': chatId,
      'user_id': 'test_user',
      'user_name': 'Test User',
      'user_photo': '',
      'last_message': 'This is a test message',
      'last_message_time': FieldValue.serverTimestamp(),
      'unread_count': 1,
    });
    
    // Create main chat document
    await _firestore.collection('chats').doc(chatId).set({
      'user_id': 'test_user',
      'admin_id': currentUser.id,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
      'last_message': 'This is a test message',
      'last_message_time': FieldValue.serverTimestamp(),
      'unread_user': 0,
      'unread_admin': 1,
      'status': 'active',
    });
  }
}

// In ChatService
Future<bool> isAdminOnline(String adminId) async {
  try {
    DocumentSnapshot adminDoc = await FirebaseFirestore.instance.collection('admins')
        .doc(adminId)
        .get();
    
    return adminDoc.exists && 
           adminDoc.data() is Map<String, dynamic> && 
           (adminDoc.data() as Map<String, dynamic>)['online'] == true;
  } catch (e) {
    log('Error checking admin status: $e');
    return false;
  }
}

  
  // Update user online status
  Future<void> updateOnlineStatus(bool isOnline) async {
    try {
      UserModel currentUser = await _getCurrentUser();
      bool isAdmin = await isUserAdmin();
      
      // Update status based on user type
      if (isAdmin) {
        await _firestore.collection('admins').doc(currentUser.id).update({
          'online': isOnline,
          'last_active': FieldValue.serverTimestamp(),
        });
      }
      
      // Always update in users collection
      await _firestore.collection('users').doc(currentUser.id).update({
        'online': isOnline,
        'last_active': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      log('Error updating online status: $e');
    }
  }
}