import 'package:flutter/material.dart';
import 'package:hr_app/screens/calendar/calendar_screen.dart';
import 'package:hr_app/screens/chat/chat_display.dart';
import 'package:hr_app/screens/home/home_screen.dart';
import 'package:hr_app/screens/leave/leave.dart';
import 'package:hr_app/screens/notification/notification_screen.dart';
import 'package:hr_app/screens/parent_chat/chat_display_parent.dart';
import 'package:hr_app/screens/payroll/payroll.dart';
import 'package:hr_app/screens/profile/profile_screen.dart';

import 'chat/chat_screen.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    LeaveScreen(),
    HomeScreen(),
    Payroll(),
    ChatScreen(),
    NotificationScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run_outlined),
            label: 'Leave',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Payroll',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_notifications),
            label: 'Notice',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black.withAlpha(90),
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
