import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awsome_notification_project/core/constants/notification_constants.dart';
import 'package:awsome_notification_project/core/utils/schedule_dialog.dart';
import 'package:awsome_notification_project/core/utils/unique_id_provider.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

abstract class AwesomeNotificationsService {
  static Future<void> createBasicNotification({
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
        locked: true,
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

  static Future<void> createMediaNotification({
    required String musicTitle,
    bool isPlaying = false,
  }) async {
    await awesomeNotifications.createNotification(
      content: NotificationContent(
        id: 13,
        channelKey: NotificationConstants.musicChannelKey,
        title: 'Awesome Notification🎵 Now playing',
        body: 'Bright Sharp\n$musicTitle',
        notificationLayout: NotificationLayout.MediaPlayer,
        locked: true,
        bigPicture: "resource://drawable/res_bg_music",
        payload: {"id": "13", "title": musicTitle, "isPlaying": "$isPlaying"},
      ),

      actionButtons: [
        NotificationActionButton(
          key: 'PREV',
          label: ' ',
          icon: 'resource://drawable/res_previous_button',
          autoDismissible: false,
          showInCompactView: true,
          actionType: ActionType.KeepOnTop,
        ),
        NotificationActionButton(
          key: 'PLAY_PAUSE',
          label: ' ',
          showInCompactView: true,
          icon: isPlaying
              ? 'resource://drawable/res_pause_button'
              : 'resource://drawable/res_play_button',
          autoDismissible: false,
          actionType: ActionType.KeepOnTop,
        ),
        NotificationActionButton(
          key: 'NEXT',
          label: ' ',
          icon: 'resource://drawable/res_next_button',
          color: Colors.teal,
          showInCompactView: true,
          autoDismissible: false,
          actionType: ActionType.KeepOnTop,
        ),
        NotificationActionButton(
          key: 'CLOSE',
          label: ' ',
          color: Colors.transparent,
          icon: 'resource://drawable/res_cancel_button',
          autoDismissible: true,
          actionType: ActionType.KeepOnTop,
        ),
      ],
    );
  }

  static Future<void> cancelScheduledNotifications() async {
    await awesomeNotifications.cancelAll();
    //await awesomeNotifications.cancelAllSchedules();
  }
}
