import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hr_app/screens/chat/chat_display.dart';
import 'package:hr_app/widgets/chat/new_message.dart';
import 'package:hr_app/widgets/chat/messages.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
            child: Column(
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  child: Text(subject, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),
                Expanded(child: Messages()),
                NewMessage(),
              ]
            ),
          ),
    );
  }
}