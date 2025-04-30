
// import 'dart:developer';

// import 'package:beauty/service/chatService.dart';
// import 'package:beauty/views/profile/help/chat.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:beauty/models/user.model.dart';
// import 'package:get/get.dart';
// import 'package:beauty/service/user_session/user_session.dart';

// import 'package:intl/intl.dart';

// // Main chat list screen
// class ChatsListScreen extends StatefulWidget {
//   const ChatsListScreen({super.key});

//   @override
//   State<ChatsListScreen> createState() => _ChatsListScreenState();
// }

// class _ChatsListScreenState extends State<ChatsListScreen> {
//   final ChatService _chatService = ChatService();
//   bool isAdmin = false;


//   @override
// void initState() {
//   super.initState();
//   _checkUserType();
//   _chatService.updateOnlineStatus(true);
//   // Add debug logging
//   _printDebugInfo();
// }

// Future<void> _printDebugInfo() async {
//   // Check if admin status is detected correctly
//   bool adminStatus = await UserSession().getUserType() ?? false;
//   log("Is admin: $adminStatus");
  
//   // Check user ID
//   String userId = UserSession.userModel.value.id;
//   log("Current user ID: $userId");
  
//   // Check if Firestore has the collection
//   var adminChats = await FirebaseFirestore.instance
//       .collection('admin_chats')
//       .doc(userId)
//       .collection('chats')
//       .get();
  
//   log("Number of admin chats: ${adminChats.docs.length}");
//   if (adminChats.docs.isNotEmpty) {
//     log("Sample chat ID: ${adminChats.docs.first.id}");
//   }
// }


//   @override
//   void dispose() {
//     _chatService.updateOnlineStatus(false);
//     super.dispose();
//   }

//   Future<void> _checkUserType() async {
//     bool adminStatus = await UserSession().getUserType() ?? false;
//     setState(() {
//       isAdmin = adminStatus;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chats'),
//       ),
//       body:
      
//        StreamBuilder<QuerySnapshot>(
//         stream: _chatService.getChats(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
          
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
          
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('No chats yet'),
//                   SizedBox(height: 20),
//                   if (!isAdmin)
//                     ElevatedButton(
//                       onPressed: () => _showAdminsList(),
//                       child: Text('Start New Chat with Admin'),
//                     ),
//                 ],
//               ),
//             );
//           }
          
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               var chatData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
//               String chatId = chatData['chat_id'];
//               String name = isAdmin ? chatData['user_name'] : chatData['admin_name'];
//               String photoUrl = isAdmin ? chatData['user_photo'] : chatData['admin_photo'];
//               String lastMessage = chatData['last_message'] ?? '';
//               Timestamp? lastMessageTime = chatData['last_message_time'] as Timestamp?;
//               int unreadCount = chatData['unread_count'] ?? 0;
              
//               String formattedTime = lastMessageTime != null
//                   ? _formatTimestamp(lastMessageTime)
//                   : '';
                  
//               return ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: photoUrl.isNotEmpty
//                       ? NetworkImage(photoUrl)
//                       : null,
//                   child: photoUrl.isEmpty ? Icon(Icons.person) : null,
//                 ),
//                 title: Text(name),
//                 subtitle: Text(
//                   lastMessage,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 trailing: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(formattedTime, style: TextStyle(fontSize: 12)),
//                     if (unreadCount > 0)
//                       Container(
//                         padding: EdgeInsets.all(6),
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).primaryColor,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Text(
//                           unreadCount.toString(),
//                           style: TextStyle(color: Colors.white, fontSize: 12),
//                         ),
//                       ),
//                   ],
//                 ),
//                 onTap: () {
//                   Get.to(() => ChatScreen(chatId: chatId, recipientName: name));
//                 },
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: !isAdmin
//           ? FloatingActionButton(
//               onPressed: () => _showAdminsList(),
//               child: Icon(Icons.message),
//               tooltip: 'Start new chat',
//             )
//           : null,
//     );
//   }

//   String _formatTimestamp(Timestamp timestamp) {
//     DateTime dateTime = timestamp.toDate();
//     DateTime now = DateTime.now();
    
//     if (dateTime.day == now.day && dateTime.month == now.month && dateTime.year == now.year) {
//       // Today - show time only
//       return DateFormat.jm().format(dateTime);
//     } else if (dateTime.day == now.day - 1 && dateTime.month == now.month && dateTime.year == now.year) {
//       // Yesterday
//       return 'Yesterday';
//     } else if (now.difference(dateTime).inDays < 7) {
//       // Within the last week - show day name
//       return DateFormat.E().format(dateTime);
//     } else {
//       // Older - show date
//       return DateFormat.yMd().format(dateTime);
//     }
//   }
  
//   Future<void> _showAdminsList() async {
//     List<UserModel> admins = await _chatService.getAvailableAdmins();
    
//     if (admins.isEmpty) {
//       Get.snackbar(
//         'No Admins Available',
//         'There are no admins available at the moment.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }
    
//     Get.bottomSheet(
//       Container(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'Available Admins',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: admins.length,
//                 itemBuilder: (context, index) {
//                   UserModel admin = admins[index];
//                   return ListTile(
//                     leading: CircleAvatar(
//                       backgroundImage: admin.profile != null && admin.profile!.isNotEmpty
//                           ? NetworkImage(admin.profile!)
//                           : null,
//                       child: admin.profile == null || admin.profile!.isEmpty
//                           ? Icon(Icons.person)
//                           : null,
//                     ),
//                     title: Text(admin.name ?? 'Admin'),
//                     subtitle: Text(admin.email ?? ''),
//                     onTap: () async {
//                       String chatId = await _chatService.createChat(admin.id);
//                       Get.back(); // Close bottom sheet
//                       Get.to(() => ChatScreen(
//                             chatId: chatId,
//                             recipientName: admin.name ?? 'Admin',
//                           ));
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: Colors.white,
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(10),
//           topRight: Radius.circular(10),
//         ),
//       ),
//     );
//   }
// }


import 'dart:developer';
import 'package:beauty/service/chatService.dart';
import 'package:beauty/views/profile/help/chat.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beauty/models/user.model.dart';
import 'package:get/get.dart';
import 'package:beauty/service/user_session/user_session.dart';
import 'package:intl/intl.dart';

class ChatsListScreen extends StatefulWidget {
  const ChatsListScreen({super.key});

  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  final ChatService _chatService = ChatService();
  bool isAdmin = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _checkUserType();
    await _chatService.updateOnlineStatus(true);
    await _printDebugInfo();
    
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _printDebugInfo() async {
    bool adminStatus = await UserSession().getUserType() ?? false;
    log("Is admin: $adminStatus");
    
    String userId = UserSession.userModel.value.id;
    log("Current user ID: $userId");
    
    var adminChats = await FirebaseFirestore.instance
        .collection('admin_chats')
        .doc(userId)
        .collection('chats')
        .get();
    
    log("Number of admin chats: ${adminChats.docs.length}");
    if (adminChats.docs.isNotEmpty) {
      log("Sample chat ID: ${adminChats.docs.first.id}");
    }
  }

  @override
  void dispose() {
    _chatService.updateOnlineStatus(false);
    super.dispose();
  }

  Future<void> _checkUserType() async {
    bool adminStatus = await UserSession().getUserType() ?? false;
    if (mounted) {
      setState(() {
        isAdmin = adminStatus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(

        elevation: 0,
        backgroundColor: Colors.white,

        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.purple[700]),
          onPressed: () => Get.back(),
        ),  
        
        title: Text(
          'Messages',
          style: TextStyle(
            color: Colors.purple[900],
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.search, color: Colors.purple[700]),
        //     onPressed: () {
        //       // Implement search functionality
        //     },
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading 
          ? _buildLoadingState()
          : _buildChatsList(),
      ),
      floatingActionButton: !isAdmin
          ? FloatingActionButton(
              onPressed: () => _showAdminsList(),
              backgroundColor: Colors.purple[800],
              child: const Icon(Icons.chat_bubble_outline),
              tooltip: 'Start new chat',
            )
          : null,
    );
  }
  
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.purple[800]!),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading your conversations...',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getChats(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerLoading();
        }
        
        if (snapshot.hasError) {
          return _buildErrorState(snapshot.error.toString());
        }
        
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildEmptyState();
        }
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var chatData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return _buildChatTile(chatData);
            },
          ),
        );
      },
    );
  }
  
  Widget _buildShimmerLoading() {
    return ListView.builder(
      itemCount: 6,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[300],
            ),
            title: Container(
              height: 16,
              width: 120,
              color: Colors.grey[300],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 200,
                  color: Colors.grey[300],
                ),
              ],
            ),
            trailing: Container(
              height: 10,
              width: 30,
              color: Colors.grey[300],
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 60,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Oops! Something went wrong',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: TextStyle(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              _initializeData();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[700],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.purple[50],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: Colors.purple[700],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No conversations yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 56),
            child: Text(
              isAdmin 
                ? 'When clients message you, they\'ll appear here.'
                : 'Start chatting with our stylists to book appointments or ask questions.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 32),
          if (!isAdmin)
            ElevatedButton(
              onPressed: () => _showAdminsList(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Start a conversation'),
            ),
        ],
      ),
    );
  }

  Widget _buildChatTile(Map<String, dynamic> chatData) {
    String chatId = chatData['chat_id'];
    String name = isAdmin ? chatData['user_name'] : chatData['admin_name'];
    String photoUrl = isAdmin ? chatData['user_photo'] : chatData['admin_photo'];
    String lastMessage = chatData['last_message'] ?? '';
    Timestamp? lastMessageTime = chatData['last_message_time'] as Timestamp?;
    int unreadCount = chatData['unread_count'] ?? 0;
    
    String formattedTime = lastMessageTime != null
        ? _formatTimestamp(lastMessageTime)
        : '';
        
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        onTap: () {
          Get.to(() => ChatScreen(chatId: chatId, recipientName: name));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        leading: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: unreadCount > 0 ? Colors.purple : Colors.transparent,
              width: 2,
            ),
          ),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey[200],
            backgroundImage: photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
            child: photoUrl.isEmpty 
              ? Icon(Icons.person, color: Colors.grey[400], size: 26)
              : null,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              formattedTime,
              style: TextStyle(
                fontSize: 12,
                color: unreadCount > 0 ? Colors.purple[800] : Colors.grey[600],
                fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: unreadCount > 0 ? Colors.black87 : Colors.grey[600],
                    fontWeight: unreadCount > 0 ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ),
              if (unreadCount > 0)
                Container(
                  margin: const EdgeInsets.only(left: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.purple[700],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    unreadCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    DateTime now = DateTime.now();
    
    if (dateTime.day == now.day && dateTime.month == now.month && dateTime.year == now.year) {
      // Today - show time only
      return DateFormat.jm().format(dateTime);
    } else if (dateTime.day == now.day - 1 && dateTime.month == now.month && dateTime.year == now.year) {
      // Yesterday
      return 'Yesterday';
    } else if (now.difference(dateTime).inDays < 7) {
      // Within the last week - show day name
      return DateFormat.E().format(dateTime);
    } else {
      // Older - show date
      return DateFormat.MMMd().format(dateTime);
    }
  }
  
  Future<void> _showAdminsList() async {
    List<UserModel> admins = await _chatService.getAvailableAdmins();
    
    if (admins.isEmpty) {
      Get.snackbar(
        'No Stylists Available',
        'There are no stylists available at the moment. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
      );
      return;
    }
    
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Available Stylists',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple[900],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Start a conversation with one of our stylists',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: admins.length,
                itemBuilder: (context, index) {
                  UserModel admin = admins[index];
                  return _buildAdminTile(admin);
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
  
  Widget _buildAdminTile(UserModel admin) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: Colors.purple[100],
          backgroundImage: admin.profile != null && admin.profile!.isNotEmpty
              ? NetworkImage(admin.profile!)
              : null,
          child: admin.profile == null || admin.profile!.isEmpty
              ? Text(
                  admin.name != null && admin.name!.isNotEmpty
                      ? admin.name![0].toUpperCase()
                      : 'A',
                  style: TextStyle(
                    color: Colors.purple[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              : null,
        ),
        title: Text(
          admin.name ?? 'Stylist',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            admin.email != null && admin.email!.isNotEmpty
                ? Text(
                    admin.email!,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Online now',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Container(
          decoration: BoxDecoration(
            color: Colors.purple[700],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: const Text(
            'Chat',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () async {
          Get.back(); // Close bottom sheet
          
          // Show loading dialog
          Get.dialog(
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.purple[800]!),
                    ),
                    const SizedBox(height: 16),
                    const Text('Connecting...'),
                  ],
                ),
              ),
            ),
            barrierDismissible: false,
          );
          
          try {
            String chatId = await _chatService.createChat(admin.id);
            Get.back(); // Close loading dialog
            Get.to(() => ChatScreen(
                  chatId: chatId,
                  recipientName: admin.name ?? 'Stylist',
                ));
          } catch (e) {
            Get.back(); // Close loading dialog
            Get.snackbar(
              'Connection Error',
              'Could not start chat. Please try again.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red[100],
              colorText: Colors.red[900],
              margin: const EdgeInsets.all(16),
              borderRadius: 8,
            );
          }
        },
      ),
    );
  }
}