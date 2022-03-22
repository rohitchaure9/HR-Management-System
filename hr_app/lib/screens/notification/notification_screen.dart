import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

int selectedIndex = 0;

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _controller = new TextEditingController();

  var _enteredEvent = '';
  var _eventDate;
  var _sortDate;

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _eventDate = DateFormat.yMMMMd().format(value);
        _sortDate = value;
      });
    });
  }

  void _addEvent() async {
    FocusScope.of(context).unfocus();
    Firestore.instance.collection('events').add({
      'name': _enteredEvent,
      'date': _eventDate,
      'sort': _sortDate,
    });
    _controller.clear();
    setState(() {
      _eventDate = null;
    });
  }

  void _bottomSheetEvent(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return Center(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: TextField(
                      controller: _controller,
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: true,
                      enableSuggestions: true,
                      decoration: InputDecoration(labelText: 'Event name'),
                      onChanged: (value) {
                        setState(() {
                          _enteredEvent = value;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 2, bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_eventDate == null
                          ? 'Date not selected'
                          : _eventDate.toString()),
                      FlatButton(
                        onPressed: () => _showDatePicker(),
                        child: Text(
                          'Select Date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  color: Colors.deepPurple,
                  onPressed: () {
                    _addEvent();
                    Navigator.pop(context);
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withAlpha(90),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Create Notice',
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: FirebaseAuth.instance.currentUser(),
              builder: (ctx, futureSnapshot) {
                if (futureSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return StreamBuilder(
                    stream: Firestore.instance
                        .collection('events')
                        .orderBy(
                          'sort',
                        )
                        .snapshots(),
                    builder: (ctx, chatSnapshot) {
                      if (chatSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final chatDocs = chatSnapshot.data.documents;
                      return ListView.builder(
                          itemCount: chatDocs.length,
                          itemBuilder: (ctx, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 2, bottom: 2),
                              child: Card(
                                child: ListTile(
                                  title: Text(
                                    chatDocs[index]['name'],
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle:
                                      Text(chatDocs[index]['date'].toString()),
                                ),
                              ),
                            );
                          });
                    });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          backgroundColor: Colors.deepPurple,
          onPressed: () {
            _bottomSheetEvent(context);
          }),
    );
  }
}
