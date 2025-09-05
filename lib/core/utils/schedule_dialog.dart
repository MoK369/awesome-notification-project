import 'package:awsome_notification_project/core/constants/notification_constants.dart';
import 'package:flutter/material.dart';

abstract class ScheduleDialog {
  static Future<NotificationWeekAndTime?> showScheduleDialog(
    BuildContext context,
  ) async {
    TimeOfDay? timeOfDay;
    int? selectedDay;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("I want to be reminded every"),
          actionsAlignment: MainAxisAlignment.start,
          content: Wrap(
            spacing: 4.0,
            runSpacing: 8.0,
            alignment: WrapAlignment.center,
            children: List.generate(NotificationConstants.daysOfTheWeek.length, (index) {
              return FilledButton(
                onPressed: () {
                  selectedDay = index + 1;
                  Navigator.pop(context);
                },
                child: Text(NotificationConstants.daysOfTheWeek[index]),
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
