import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awsome_notification_project/core/constants/notification_constants.dart';
import 'package:awsome_notification_project/core/utils/schedule_dialog.dart';
import 'package:awsome_notification_project/core/utils/unique_id_provider.dart';

import '../../main.dart';

abstract class Notifications {
  static Future<void> createNormalNotification({
    required String? title,
    required String? body,
    required String? picturePath,
    NotificationLayout notificationLayout = NotificationLayout.BigPicture,
  }) async {
    await awesomeNotifications.createNotification(
      content: NotificationContent(
        id: UniqueIdProvider.provide(),
        channelKey: NotificationConstants.basicChannelKey,
        title: title,
        body: body,
        bigPicture: picturePath,
        notificationLayout: notificationLayout,
      ),
    );
  }

  static Future<void> createScheduledNotification({
    required NotificationWeekAndTime notificationSchedule,
    required String? title,
    required String? body,
    NotificationLayout notificationLayout = NotificationLayout.Default,
  }) async {
    await awesomeNotifications.createNotification(
      content: NotificationContent(
        id: UniqueIdProvider.provide(),
        channelKey: NotificationConstants.scheduledChannelKey,
        title: title,
        body: body,
        notificationLayout: notificationLayout,
      ),
      actionButtons: [
        NotificationActionButton(
          key: NotificationConstants.markDoneActionButtonKey,
          label: "Mark Done",
        ),
      ],
      schedule: NotificationCalendar(
        weekday: notificationSchedule.dayOfTheWeek,
        hour: notificationSchedule.timeOfDay?.hour,
        minute: notificationSchedule.timeOfDay?.minute,
        second: 0,
        millisecond: 0,
        //repeats:
      ),
    );
  }

  static Future<void> cancelScheduledNotifications() async{
    await awesomeNotifications.cancelAllSchedules();
  }
}
