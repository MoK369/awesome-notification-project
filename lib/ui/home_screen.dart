import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awsome_notification_project/core/constants/notification_constants.dart';
import 'package:awsome_notification_project/core/utils/notification_stream_methods.dart';
import 'package:awsome_notification_project/core/utils/notifications.dart';
import 'package:awsome_notification_project/core/utils/schedule_dialog.dart';
import 'package:awsome_notification_project/ui/scheduled_notifications/scheduled_notifications.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Size size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  void initState() {
    super.initState();
    awesomeNotifications.isNotificationAllowed().then((isAllowed) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Allow Notifications"),
                content: const Text(
                  "Our app would like to send you notifications",
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Don't Allow",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      awesomeNotifications
                          .requestPermissionToSendNotifications();
                    },
                    child: const Text(
                      "Allow",
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      });
    });
    awesomeNotifications.setListeners(
      onNotificationCreatedMethod: (receivedNotification) async {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(
        //       "Notification created on ${receivedNotification.channelKey}",
        //     ),
        //   ),
        // );
      },
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationDisplayedMethod:
          NotificationStreamMethods.onNotificationDisplayedMethod,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Awesome Notification"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ScheduledNotifications(),
                ),
              );
            },
            icon: const Icon(Icons.insert_chart_outlined, size: 30),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/plant_image.jpg",
              width: size.width * 0.5,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton(
                  onPressed: () async {
                    await AwesomeNotificationsService.createBasicNotification(
                      title:
                          "${Emojis.money_money_bag} ${Emojis.plant_cactus} Buy Plant Food",
                      body: "Florist at 123 Main St. has 2 in stock",
                      picturePath: "asset://assets/images/on_the_map.jpg",
                    );
                  },
                  child: const Text("\$Plant Food"),
                ),
                FilledButton(
                  onPressed: () async {
                    var previousScheduledNotifications =
                        await awesomeNotifications.listScheduledNotifications();
                    if (!context.mounted) return;
                    if (previousScheduledNotifications.length >= 5) {
                      await ScheduleDialog.showMaximumScheduledNotificationDialog(
                        context,
                      );
                      return;
                    }
                    var result = await ScheduleDialog.showScheduleDialog(
                      context,
                    );
                    if (result?.timeOfDay == null ||
                        result?.dayOfTheWeek == null) {
                      return;
                    }
                    AwesomeNotificationsService.createScheduledNotification(
                      notificationSchedule: result!,
                      title: "${Emojis.wheater_droplet} water your plant",
                      body: "Water your plant regularly to keep it healthy",
                    );
                  },
                  child: const Text("💧Water"),
                ),
                FilledButton(
                  onPressed: () async {
                    await AwesomeNotificationsService.createMediaNotification(
                      musicTitle: "Champagne Supernova",
                    );
                  },
                  child: const Text("🎵Play Music"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                AwesomeNotificationsService.cancelScheduledNotifications();
              },
              child: const Text("❌cancel"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    awesomeNotifications.dispose();
  }
}

@pragma("vm:entry-point")
Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
  print("An action has been given ${receivedAction.buttonKeyInput}");
  if (receivedAction.buttonKeyPressed == 'PLAY_PAUSE') {
    print("${bool.parse(receivedAction.payload!['isPlaying']!)}");
    await AwesomeNotificationsService.createMediaNotification(
      musicTitle: receivedAction.payload!["title"]!,
      isPlaying: !(bool.parse(receivedAction.payload!['isPlaying']!)),
    );
  }
  if (receivedAction.channelKey == NotificationConstants.basicChannelKey &&
      Platform.isIOS) {
    awesomeNotifications.getGlobalBadgeCounter().then((value) {
      awesomeNotifications.setGlobalBadgeCounter(value - 1);
    });
  }
  // Handle notification tap or button press
  debugPrint(
    "Notification Action Received: ${receivedAction.buttonKeyPressed}",
  );
}
