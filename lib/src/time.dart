import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String serverTimeFormat(TimeOfDay time) {
  if (time == null) return null;

  var hour = time.hour < 10 ? '0${time.hour}' : time.hour;
  var minute = time.minute < 10 ? '0${time.minute}' : time.minute;

  return '$hour:$minute';
}

final serverFormatter = DateFormat('yyyy-MM-dd', 'en');

String serverDateFormat(DateTime date) {
  if (date == null) return null;

  return serverFormatter.format(date);
}


bool isInRange(int time, int startTime, int endTime) =>
    time >= startTime && time <= endTime;

extension TimeStringExtentions on String {
  DateTime toDateTimeFromServerFormat() => serverFormatter.parse(this);
}

extension on TimeOfDay {
  int toInt() => minute + (hour * 60);
}

extension on DateTime {
  TimeOfDay toTimeOfDay() => TimeOfDay.fromDateTime(this);
}
