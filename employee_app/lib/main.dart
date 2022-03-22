import 'package:app_usage/app_usage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:employee_app/screens/auth/auth_screen.dart';
import 'package:employee_app/screens/chat/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:employee_app/screens/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<AppUsageInfo> _infos = [];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      print('Loop');
      getUsageStats();
    });
  }

  void getUsageStats() async {
    print('Loop2');
    final List packageNames = [
      'com.instagram.android',
      'com.vanced.android.youtube',
      'com.example.employee_app',
      'com.whatsapp',
      'com.google.android.apps.docs',
      'org.lichess.mobileapp'
    ];
    final user = await FirebaseAuth.instance.currentUser();
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(Duration(days: 1));
      infoList = await AppUsage.getAppUsage(startDate, endDate);
      setState(() {
        _infos = infoList;
      });

      print(infoList);
      for (var info in infoList) {
        if (packageNames.contains(info.packageName)) {
          Firestore.instance
              .collection('users')
              .document('IUOs02z8ySQTT31oEDIwvrbgKuI3')
              .collection('app usage data')
              .document(info.packageName)
              .setData({
            'usage': info.usage.toString(),
            'name': info.packageName,
          });
        }
        print('done');
      }
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        backgroundColor: Colors.purpleAccent,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.purple,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return MainPage();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
