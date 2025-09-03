import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awsome_notification_project/core/constants/notification_constants.dart';
import 'package:awsome_notification_project/core/theme/app_theme.dart';
import 'package:awsome_notification_project/home_screen.dart';
import 'package:flutter/material.dart';

AwesomeNotifications awesomeNotifications = AwesomeNotifications();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await awesomeNotifications
      .initialize("resource://drawable/res_notification_logo", [
        NotificationChannel(
          channelKey: NotificationConstants.basicChannelKey,
          channelName: "Basic Notifications",
          defaultColor: Colors.teal,
          channelDescription: "This channel is for basic notifications",
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
        NotificationChannel(
          channelKey: NotificationConstants.scheduledChannelKey,
          channelName: "Scheduled Notifications",
          defaultColor: Colors.teal,
          locked: true,
          channelDescription: "This channel is for scheduled notifications",
          importance: NotificationImportance.High,
          soundSource: "resource://raw/livechat_sound"
        ),
      ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Notification',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
