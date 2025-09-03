import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awsome_notification_project/core/constants/notification_constants.dart';
import 'package:awsome_notification_project/main.dart';
import 'package:awsome_notification_project/notification_page.dart';
import 'package:flutter/material.dart';

abstract class NotificationStreamMethods {
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Handle notification creation
    print("Notification Created: ${receivedNotification.id}");
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Handle notification display
    print("Notification Displayed: ${receivedNotification.id}");
  }

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    // Handle notification dismissal
    print("Notification Dismissed: ${receivedAction.id}");
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
    print("Notification Action Received: ${receivedAction.buttonKeyPressed}");
    // Example navigation
    MyApp.navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) =>
            NotificationPage(receivedNotification: receivedAction),
      ),
    );
  }
}
