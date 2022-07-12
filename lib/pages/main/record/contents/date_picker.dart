import 'package:dotted_border/dotted_border.dart';
import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

DateTime dateTime = DateTime.now();

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final DateRangePickerController _dateController = DateRangePickerController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.mediaQuery.size.width,
      height: Get.mediaQuery.size.width,
      child: SfDateRangePicker(
        headerHeight: 60,
        controller: _dateController,
        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) =>
            _onSelectedChanged(
          args,
          context,
        ),
      ),
    );
  }
}

_onSelectedChanged(
    DateRangePickerSelectionChangedArgs args, BuildContext context) {
  dateTime = args.value;
  _timePicker(context);
}

_timePicker(BuildContext context) async {
  Future<TimeOfDay?> selectedTime = showTimePicker(
    context: context,
    helpText: '',
    initialTime: TimeOfDay(
      hour: DateTime.now().hour,
      minute: DateTime.now().minute,
    ),
  );
  final time = await selectedTime;
  if (time == null) return;
  DateTime newDateTime = DateTime(
    dateTime.year,
    dateTime.month,
    dateTime.day,
    time.hour,
    time.minute,
  );
  dateTime = newDateTime;
  print(dateTime);
}
