import 'package:intl/intl.dart';

extension StringExtensionMethods on String {
  String convert24HoursTo12HoursFormat() {
    DateFormat inputFormat = DateFormat("HH:mm");
    DateFormat outputFormat = DateFormat("hh:mm a");
    DateTime dateTime = inputFormat.parse(this);
    return outputFormat.format(dateTime);
  }
}
