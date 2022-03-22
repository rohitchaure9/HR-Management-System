import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {

  var _enteredMessage = '';

  final _controller = TextEditingController();

  void _sendMessage() async{
    FocusScope.of(context).unfocus();
    // final user = await FirebaseAuth.instance.currentUser();
    // final userData = await Firestore.instance.collection('users').document(user.uid).collection('user data').document('test').get();
    Firestore.instance.collection('chats').add({
      'text': _enteredMessage,
      'time': Timestamp.now(),
      // 'sender': userData['username'],
      // 'userID': user.uid
    });
    print('ge');
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(child: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Write a message'),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
          ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            ),
        ],
      ),
    );
  }
}