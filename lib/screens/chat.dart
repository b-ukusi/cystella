import 'package:flutter/material.dart';

class ChatArea extends StatefulWidget {
  const ChatArea({super.key});

  @override
  State<ChatArea> createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
    int currentIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Text("Chat area");
  }
}