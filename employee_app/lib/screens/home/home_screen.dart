import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final _controller = new TextEditingController();
  final _controller1 = new TextEditingController();

  var _enteredName = '';
  var _eventDate;
  var _endDate;
  var _sortDate;
  var _reason;
  var _approved = '';

  void _showDatePicker() {
    print('23');
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

  void _showEndDatePicker() {
    print('23');
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
        _endDate = DateFormat.yMMMMd().format(value);
        _sortDate = value;
      });
    });
  }

  void _addEvent() async {
    FocusScope.of(context).unfocus();
    Firestore.instance.collection('leave').add({
      'name': _enteredName,
      'reason': _reason,
      'date': _eventDate,
      'lastdate': _endDate,
      'sort': _sortDate,
      'approed': _approved,
      'employee': 'Aditi',
    });
    _controller.clear();
    _controller1.clear();
    setState(() {
      _eventDate = null;
      _endDate = null;
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
                      decoration: InputDecoration(labelText: 'Department'),
                      onChanged: (value) {
                        setState(() {
                          _enteredName = value;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: TextField(
                      controller: _controller1,
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: true,
                      enableSuggestions: true,
                      decoration: InputDecoration(labelText: 'Reason'),
                      onChanged: (vale) {
                        setState(() {
                          _reason = vale;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 2, bottom: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Leave From'),
                      Row(
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 2, bottom: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Leave Till'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(_endDate == null
                              ? 'Date not selected'
                              : _endDate.toString()),
                          FlatButton(
                            onPressed: () => _showEndDatePicker(),
                            child: Text(
                              'Select Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
      backgroundColor: Theme.of(context).backgroundColor.withAlpha(90),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Ask for Leave',
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
                        .collection('leave')
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
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: ListTile(
                                    trailing:
                                        chatDocs[index]['approed'] == 'true'
                                            ? Icon(
                                                Icons.check,
                                                color: Colors.green,
                                              )
                                            : Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                              ),
                                    title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            'Start Date :' +
                                                chatDocs[index]['date']
                                                    .toString(),
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            'End Date :' +
                                                chatDocs[index]['lastdate']
                                                    .toString(),
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
