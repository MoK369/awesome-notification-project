import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final ReceivedAction receivedNotification;
  const NotificationPage({super.key, required this.receivedNotification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notification Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "----- ${receivedNotification.title} -----",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12,),
            Text(
              "${receivedNotification.body}",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "${receivedNotification.channelKey}",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
