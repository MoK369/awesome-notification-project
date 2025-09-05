import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awsome_notification_project/core/base_view_state/base_view_state.dart';
import 'package:awsome_notification_project/main.dart';
import 'package:flutter/material.dart';

class ScheduledNotificationViewModel extends ChangeNotifier {
  List<NotificationModel> _scheduledNotifications = [];
  BaseViewState<List<NotificationModel>> getScheduledNotificationResult =
      IdleState();

  BaseViewState<void> cancelScheduledNotificationStatus = IdleState();

  void getScheduledNotifications() async {
    try {
      getScheduledNotificationResult = LoadingState();
      notifyListeners();
      _scheduledNotifications = await awesomeNotifications
          .listScheduledNotifications();
      getScheduledNotificationResult = SuccessState<List<NotificationModel>>(
        data: _scheduledNotifications,
      );
    } catch (e) {
      getScheduledNotificationResult = ErrorState(error: e);
    }
    notifyListeners();
  }

  void deleteScheduledNotification(int notificationId) async {
    try {
      cancelScheduledNotificationStatus = LoadingState(
        message: "$notificationId",
      );
      notifyListeners();
      await awesomeNotifications.cancel(notificationId);
      cancelScheduledNotificationStatus = SuccessState(data: null);
    } catch (e) {
      cancelScheduledNotificationStatus = ErrorState(error: e);
    }
    notifyListeners();
    Future.delayed(const Duration(seconds: 2), () {
      cancelScheduledNotificationStatus = IdleState();
    });
  }
}
