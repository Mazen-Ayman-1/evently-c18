import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  DateTime get dateOnly {
    return DateTime(year, month, day);
  }
}

extension IntExtention on int {
  String get formatedDate {
    // convert int to datetime

    DateTime date = DateTime.fromMillisecondsSinceEpoch(this);

    // get string format for date from datetime

    String formattedDateValue = DateFormat("dd\nMMM").format(date);
    return formattedDateValue;
  }
}
