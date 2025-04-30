

import 'dart:io';
import 'package:beauty/service/chatService.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beauty/service/user_session/user_session.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String recipientName;

  ChatScreen({required this.chatId, required this.recipientName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _imagePicker = ImagePicker();
  String? currentUserId;
  bool isAdmin = false;
  
  @override
  void initState() {
    super.initState();
    _getUserInfo();
    _markMessagesAsRead();
  }
  
  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  
  Future<void> _getUserInfo() async {
    currentUserId = UserSession.userModel.value.id;
    isAdmin = await UserSession().getUserType() ?? false;
    setState(() {});
  }
  
  Future<void> _markMessagesAsRead() async {
    await _chatService.markMessagesAsRead(widget.chatId);
  }
  
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  
  Future<void> _sendMessage() async {
    String message = _messageController.text.trim();
    if (message.isEmpty) return;
    
    _messageController.clear();
    
    await _chatService.sendMessage(widget.chatId, message);
    
    // Scroll to bottom after message is sent
    Future.delayed(Duration(milliseconds: 100), _scrollToBottom);
  }
  
  Future<void> _pickAndSendImage() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    
    if (image != null) {
      File imageFile = File(image.path);
      await _chatService.sendImageMessage(widget.chatId, imageFile);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.recipientName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
            ),
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16,
              child: Icon(
                Icons.question_mark,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat messages area
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _chatService.getMessages(widget.chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No messages yet'));
                }
                
                // Mark messages as read
                _markMessagesAsRead();
                
                // Schedule scroll to bottom after build
                WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var messageData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                    
                    String senderId = messageData['sender_id'] ?? '';
                    String senderType = messageData['sender_type'] ?? '';
                    String content = messageData['content'] ?? '';
                    String type = messageData['type'] ?? 'text';
                    String fileUrl = messageData['file_url'] ?? '';
                    bool isRead = messageData['read'] ?? false;
                    Timestamp? timestamp = messageData['timestamp'] as Timestamp?;
                    
                    bool isCurrentUser = senderId == currentUserId;
                    
                    // Time formatting
                    String time = timestamp != null 
                        ? DateFormat.jm().format(timestamp.toDate())
                        : '';
                    
                    return _buildMessageBubble(
                      isMe: isCurrentUser,
                      text: content,
                      time: time,
                      isRead: isRead,
                      type: type,
                      fileUrl: fileUrl,
                    );
                  },
                );
              },
            ),
          ),

          // Message input area
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                // Container(
                //   decoration: const BoxDecoration(
                //     shape: BoxShape.circle,
                //   ),
                //   child: IconButton(
                //     icon: const Icon(Icons.mic, color: Colors.grey),
                //     onPressed: () {},
                //   ),
                // ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type message...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // IconButton(
                //   icon: const Icon(Icons.attach_file, color: Colors.grey),
                //   onPressed: _pickAndSendImage,
                // ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Color(0xFFAA2FB0),
                  ),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble({
    required bool isMe,
    required String text,
    required String time,
    required bool isRead,
    required String type,
    required String fileUrl,
  }) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isMe)
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.more_horiz,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
            Container(
              constraints: const BoxConstraints(maxWidth: 280),
              margin: EdgeInsets.only(
                left: isMe ? 0 : 8,
                right: isMe ? 8 : 0,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: isMe
                    ? null
                    : const LinearGradient(
                        colors: [Color(0xFFAA2FB0), Color(0xFFE773AD)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                color: isMe ? Colors.white : null,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
                border: isMe
                    ? Border.all(color: Colors.grey.shade200)
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (type == 'text')
                    Text(
                      text,
                      style: TextStyle(
                        color: isMe ? Colors.black : Colors.white,
                        fontSize: 16,
                      ),
                    )
                  else if (type == 'image')
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        fileUrl,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 200,
                            width: 200,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / 
                                      loadingProgress.expectedTotalBytes!
                                    : null,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  isMe ? const Color(0xFFAA2FB0) : Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          color: isMe
                              ? Colors.grey
                              : Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 4),
                        Icon(
                          isRead ? Icons.done_all : Icons.done,
                          size: 12,
                          color: Colors.grey,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            if (isMe)
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.more_horiz,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}