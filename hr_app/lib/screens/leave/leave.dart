import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveScreen extends StatefulWidget {
  @override
  LeaveScreenState createState() => LeaveScreenState();
}

class LeaveScreenState extends State<LeaveScreen> {
  final _controller = new TextEditingController();
  final _controller1 = new TextEditingController();

  var _enteredName = '';
  var _eventDate;
  var _sortDate;
  var _reason;

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

  void _approveLeave() async {
    FocusScope.of(context).unfocus();
    Firestore.instance
        .collection('leave')
        .document('BzQhDQfqW9wqOFbLz3tC')
        .updateData({
      'approed': 'true',
    });
    // Firestore.instance.collection('leave').add({
    //   'approed': 'true',
    // });
  }

  void _denyLeave() async {
    FocusScope.of(context).unfocus();
    Firestore.instance
        .collection('leave')
        .document('BzQhDQfqW9wqOFbLz3tC')
        .updateData({
      'approed': 'false',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withAlpha(80),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Leave Management',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    )),
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Card(
                                  child: ListTile(
                                    trailing: chatDocs[index]['approed'] != ""
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: chatDocs[index]['approed'] ==
                                                    "true"
                                                ? Text(
                                                    'Approved',
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                : Text(
                                                    'Denied',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                          )
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: IconButton(
                                                  onPressed: _denyLeave,
                                                  icon: Icon(Icons.cancel),
                                                  color: Colors.red,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: IconButton(
                                                  onPressed: _approveLeave,
                                                  icon: Icon(Icons.check),
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                    title: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          chatDocs[index]['employee'],
                                          style: TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          chatDocs[index]['name'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text('Start Date :' +
                                              chatDocs[index]['date']
                                                  .toString()),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text('End Date :' +
                                              chatDocs[index]['lastdate']
                                                  .toString()),
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
    );
  }
}
