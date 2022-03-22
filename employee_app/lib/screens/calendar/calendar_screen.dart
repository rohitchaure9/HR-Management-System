import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController _controller = CalendarController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TableCalendar(
        calendarController: _controller,
      ),
      
    );
  }
}