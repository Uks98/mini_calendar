import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:today_my_calendar/screen/widget/w_menu_drawer.dart';

class CalendarMonthPage extends StatefulWidget {
  const CalendarMonthPage({super.key});

  @override
  State<CalendarMonthPage> createState() => _CalendarMonthPageState();
}

class _CalendarMonthPageState extends State<CalendarMonthPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SfCalendar(
        view: CalendarView.month,
      ),
    );
  }
}
