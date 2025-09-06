import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awsome_notification_project/core/base_view_state/base_view_state.dart';
import 'package:awsome_notification_project/main.dart';
import 'package:flutter/material.dart';

class ScheduledNotificationViewModel extends ChangeNotifier {
  List<NotificationModel> _scheduledNotifications = [];
  BaseViewState<List<NotificationModel>> getScheduledNotificationResult =
      IdleState();

  CancelScheduledNotificationData cancelScheduledNotificationData =
      CancelScheduledNotificationData(status: IdleState());

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
      cancelScheduledNotificationData.id = notificationId;
      cancelScheduledNotificationData.status = LoadingState();
      notifyListeners();
      await awesomeNotifications.cancel(notificationId);
      cancelScheduledNotificationData.status = SuccessState(data: null);
    } catch (e) {
      cancelScheduledNotificationData.status = ErrorState(error: e);
    }
    notifyListeners();

    _scheduledNotifications.removeAt(
      _scheduledNotifications.indexWhere(
        (element) => element.content!.id == cancelScheduledNotificationData.id,
      ),
    );
    getScheduledNotificationResult = SuccessState<List<NotificationModel>>(
      data: _scheduledNotifications,
    );
    notifyListeners();
    cancelScheduledNotificationData.id = null;
    cancelScheduledNotificationData.status = IdleState();
  }
}

class CancelScheduledNotificationData {
  int? id;
  BaseViewState<void> status;
  CancelScheduledNotificationData({this.id, required this.status});
}
