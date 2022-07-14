import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:dutch_hallae/getx/controller/record_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final DateRangePickerController _dateController = DateRangePickerController();
  DateTime dateTime = DateTime.now();
  late TimeOfDay defaultTime;

  @override
  void initState() {
    int minute = _setDefaultTime();
    defaultTime = TimeOfDay(hour: DateTime.now().hour, minute: minute);
    super.initState();
  }

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

  _onSelectedChanged(
      DateRangePickerSelectionChangedArgs args, BuildContext context) {
    dateTime = args.value;
    Get.put(RecordController()).meetingDateTime = dateTime;
    _dayNightTimePicker();
  }

  _dayNightTimePicker() {
    Navigator.of(context).push(
      showPicker(
        context: context,
        value: defaultTime,
        onChange: _onTimeChanged,
        minuteInterval: MinuteInterval.FIVE,
        okText: '확인',
        cancelText: '취소',
        blurredBackground: true,
        maxMinute: 55,
      ),
    );
  }

  _onTimeChanged(TimeOfDay newTime) {
    DateTime newDateTime = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      newTime.hour,
      newTime.minute,
    );
    dateTime = newDateTime;
    Get.put(RecordController()).meetingDateTime = dateTime;
  }

  int _setDefaultTime() {
    int rawMinute = DateTime.now().minute;
    if (rawMinute % 5 != 5) {
      int fixingMinute = rawMinute % 5;
      int fixedMinute = rawMinute - fixingMinute;
      return fixedMinute;
    } else {
      return rawMinute;
    }
  }
}
