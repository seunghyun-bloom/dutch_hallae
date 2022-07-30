import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MiniCalendar extends StatelessWidget {
  final DateTime dateTime;
  const MiniCalendar({Key? key, required this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.mediaQuery.size.width,
      child: SfCalendar(
        headerDateFormat: 'yyyy년  MM월',
        view: CalendarView.month,
        monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        ),
        initialSelectedDate: dateTime,
        initialDisplayDate: dateTime,
        dataSource: MeetingDataSource(_getDataSource()),
        showCurrentTimeIndicator: false,
        selectionDecoration:
            BoxDecoration(border: Border.all(color: Colors.transparent)),
      ),
    );
  }

  List<Appointment> _getDataSource() {
    final List<Appointment> meetings = <Appointment>[];
    meetings.add(Appointment(
      startTime: dateTime,
      endTime: dateTime,
      color: Colors.red,
      isAllDay: true,
    ));
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
