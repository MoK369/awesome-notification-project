import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awsome_notification_project/core/constants/notification_constants.dart';
import 'package:awsome_notification_project/main.dart';
import 'package:awsome_notification_project/ui/notification_page.dart';
import 'package:flutter/material.dart';

abstract class NotificationStreamMethods {
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Handle notification creation
    debugPrint("Notification Created: ${receivedNotification.id}");
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Handle notification display
    debugPrint("Notification Displayed: ${receivedNotification.id}");
  }

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    // Handle notification dismissal
    debugPrint("Notification Dismissed: ${receivedAction.id}");
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    if (receivedAction.channelKey == NotificationConstants.basicChannelKey &&
        Platform.isIOS) {
      awesomeNotifications.getGlobalBadgeCounter().then((value) {
        awesomeNotifications.setGlobalBadgeCounter(value - 1);
      });
    }
    // Handle notification tap or button press
    debugPrint("Notification Action Received: ${receivedAction.buttonKeyPressed}");
    // Example navigation
    MyApp.navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) =>
            NotificationPage(receivedNotification: receivedAction),
      ),
    );
  }
}
