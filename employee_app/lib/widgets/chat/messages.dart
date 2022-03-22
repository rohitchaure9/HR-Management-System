import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:employee_app/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
                  builder: (ctx, futureSnapshot) {
                    if(futureSnapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }
                    return StreamBuilder(
      stream: Firestore.instance.collection('chats').orderBy('time', descending: true).snapshots(),
      builder: (ctx, chatSnapshot) {
        if(chatSnapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        final chatDocs = chatSnapshot.data.documents;
        return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (ctx, index) => MessageBubble(
              chatDocs[index]['text'], 
              chatDocs[index]['sender'],
              chatDocs[index]['userID'] == futureSnapshot.data.uid,
              key: ValueKey(chatDocs[index].documentID)
              ),);
                  } 
        );
       },
    );
  }
}