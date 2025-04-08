import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Message {
  final String text;
  final String time;
  final bool isMe;
  final bool showMenu;

  Message({
    required this.text,
    required this.time,
    required this.isMe,
    this.showMenu = false,
  });
}

class HelpViewController extends GetxController {
  final messages = <Message>[
    Message(
      text: 'Hi Justin',
      time: '8 Minutes Ago',
      isMe: false,
    ),
    Message(
      text: 'Do you already got the brief?',
      time: '8 Minutes Ago',
      isMe: false,
    ),
    Message(
      text: 'Yes I got the brief, no worries and I\'ll check it later today',
      time: '7 Minutes Ago',
      isMe: true,
    ),
    Message(
      text: 'Please tell me if you have any question',
      time: '2 Minutes Ago',
      isMe: false,
    ),
    Message(
      text: 'Please tell me if you have any question',
      time: '2 Minutes Ago',
      isMe: false,
    ),
    Message(
      text: 'I\'ll check it for a moment, please wait',
      time: '2 Minutes Ago',
      isMe: true,
    ),
  ].obs;

  final textController = TextEditingController();

  void sendMessage() {
    if (textController.text.trim().isNotEmpty) {
      messages.add(Message(
        text: textController.text,
        time: 'Just now',
        isMe: true,
      ));
      textController.clear();
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
