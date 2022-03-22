import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

int selectedIndex = 0;

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
final _controller1 = new TextEditingController();
final _controller2 = new TextEditingController();
final _controller3 = new TextEditingController();

  void _launchURL(String _url) async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';


    var _enteredSubject = '';
    var _enteredDrive = '';
    var _enteredLecture = '';

void _addSubject(String subject) async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('common').add({
    'name': _enteredSubject,
    'drive': _enteredDrive,
    'lecture': _enteredLecture,
    });
    _controller1.clear();
    _controller2.clear();
    _controller3.clear();
  }

void _onItemTapped(int index) {
  setState(() {
    selectedIndex = index;
  });
}

void _bottomSheetSubject(BuildContext ctx) {
  showModalBottomSheet(context: ctx, builder: (_) {
    return Center(
        child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: TextField(
                controller: _controller1,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(labelText: 'Subject Name'),
                onChanged: (value) {
                  setState(() {
                    _enteredSubject = value;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: TextField(
                controller: _controller2,
                textCapitalization: TextCapitalization.none,
                decoration: InputDecoration(labelText: 'Drive Link'),
                onChanged: (value) {
                  setState(() {
                    _enteredDrive = value;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: TextField(
                controller: _controller3,
                textCapitalization: TextCapitalization.none,
                decoration: InputDecoration(labelText: 'Meet Link'),
                onChanged: (value) {
                  setState(() {
                    _enteredLecture = value;
                  });
                },
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              _addSubject(_enteredSubject);
              Navigator.pop(context);
            },
            child: Text('Add', style: TextStyle(color: Colors.white),),
          ),
        ],
      ),);
  },
  );
}

  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Usage Report', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
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
                    if(futureSnapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }
                    return StreamBuilder(
          stream: Firestore.instance.collection('users').document('IUOs02z8ySQTT31oEDIwvrbgKuI3').collection('app usage data').snapshots(),
          builder: (ctx, dashboardSnapshot) {
            if(dashboardSnapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
            }
            final dashDocs = dashboardSnapshot.data.documents;
            print(dashDocs.length);
            return ListView.builder(
              itemCount: dashDocs.length,
              itemBuilder: (ctx, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Container(
            child: Card(
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(dashDocs[index]['name'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            trailing: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(dashDocs[index]['usage'].substring(0, 7), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            ),
          ),
            ),
              ),
            ),);
                  } 
            );
           },
        ),
        ),
      ],
    ); } 
}