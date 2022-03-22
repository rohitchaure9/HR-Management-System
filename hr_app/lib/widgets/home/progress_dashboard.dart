import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProgressDashboard extends StatefulWidget {

  @override
  _ProgressDashboardState createState() => _ProgressDashboardState();
}

class _ProgressDashboardState extends State<ProgressDashboard> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
                  builder: (ctx, futureSnapshot) {
                    if(futureSnapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }
                    return StreamBuilder(
      stream: Firestore.instance.collection('common').snapshots(),
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
              child: Text(dashDocs[index]['name'], style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Padding(                    
                      padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: 8,
                      child: LinearProgressIndicator(
          value: dashDocs[index]['obs']/dashDocs[index]['ms'],
        ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text('Average Scores'),
                ),
              ],
            ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(dashDocs[index]['al'].toString()+'/'+dashDocs[index]['tl'].toString(), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text('Attendance'),
            ),
            ],
            ),
          ),
        ),
              ),
            ),);
                  } 
        );
       },
    );
  }
}
