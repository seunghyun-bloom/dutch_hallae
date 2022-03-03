import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SfCalendar(
          view: CalendarView.month,
          monthViewSettings: MonthViewSettings(showAgenda: true),
          showDatePickerButton: true,
        ),
      ),
    );
  }
}
