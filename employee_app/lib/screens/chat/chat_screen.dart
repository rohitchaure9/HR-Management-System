import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:employee_app/screens/chat/chat_display.dart';
import 'package:employee_app/widgets/chat/new_message.dart';
import 'package:employee_app/widgets/chat/messages.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
            child: Column(
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                  child: Text(subject, style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                ),
                Expanded(child: Messages()),
                NewMessage(),
              ]
            ),
          ),
    );
  }
}