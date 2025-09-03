import 'package:flutter/material.dart';

abstract class ScheduleDialog {
  static Future<NotificationWeekAndTime?> showScheduleDialog(
    BuildContext context,
  ) async {
    List<String> weeks = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    TimeOfDay? timeOfDay;
    int? selectedDay;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("I want to be reminded every"),
          actionsAlignment: MainAxisAlignment.start,
          content: Wrap(
            spacing: 4.0,
            runSpacing: 8.0,
            alignment: WrapAlignment.center,
            children: List.generate(weeks.length, (index) {
              return FilledButton(
                onPressed: () {
                  selectedDay = index + 1;
                  Navigator.pop(context);
                },
                child: Text(weeks[index]),
              );
            }),
          ),
        );
      },
    );
    if (context.mounted) {
      timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
    }
    return NotificationWeekAndTime(
      timeOfDay: timeOfDay,
      dayOfTheWeek: selectedDay,
    );
  }
}

class NotificationWeekAndTime {
  final int? dayOfTheWeek;
  final TimeOfDay? timeOfDay;
  NotificationWeekAndTime({
    required this.timeOfDay,
    required this.dayOfTheWeek,
  });

  @override
  String toString() {
    return "$dayOfTheWeek, $timeOfDay";
  }
}
