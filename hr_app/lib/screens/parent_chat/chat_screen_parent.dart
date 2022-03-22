import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hr_app/screens/parent_chat/chat_display_parent.dart';
import 'package:hr_app/widgets/parent_chat/messages_parent.dart';
import 'package:hr_app/widgets/parent_chat/new_message_parent.dart';

class ChatScreenParent extends StatelessWidget {
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
                Expanded(child: MessagesParent()),
                NewMessageParent(),
              ]
            ),
          ),
    );
  }
}