import 'package:flutter/material.dart';

class ChatroomScreen extends StatefulWidget {
  String chatroomKey;
  ChatroomScreen(this.chatroomKey, {super.key});

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chat room'),
      ),
      body: Center(
        child: Text(widget.chatroomKey),
      ),
    );
  }
}
