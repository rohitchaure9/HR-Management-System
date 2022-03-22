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
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 28),
            child: Text('Chats', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Card(
                          child: ListTile(
                title: Text('Professor X', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Card(
                          child: ListTile(
                onTap: () {
                  setState(() {
                    subject = 'Physics';
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                },
                title: Text('Professor Y',  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                subtitle: Text('Physics'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Card(
                          child: ListTile(
                onTap: () {
                  setState(() {
                    subject = 'Chemistry';
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                },
                title: Text('Professor Z',  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                subtitle: Text('Chemistry'),
              ),
            ),
          ),
        ]
      ),
    );
  }
}