import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';

String subject = '';

class ChatDisplayScreen extends StatefulWidget {

  @override
  _ChatDisplayScreenState createState() => _ChatDisplayScreenState();
}

class _ChatDisplayScreenState extends State<ChatDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Chat', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.logout),
                   onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Card(
                          child: ListTile(
                title: Text('test', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                subtitle: Text('Math'),
                onTap: () {
                  setState(() {
                    subject = 'Math';
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                },
              ),
            ),
          ),
        ]
      ),
    );
  }
}