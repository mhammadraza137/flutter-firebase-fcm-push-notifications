import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fcm_push_notifications/services/notification_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationServices notificationServices = NotificationServices.instance();

  @override
  void initState() {
    super.initState();

    notificationServices.requestPermission();
    notificationServices.getToken();
    notificationServices.initializeNotificationServices();
    // show foreground notification in IOS
    notificationServices.showForegroundNotificationInIOS();
    //handle notification tap event when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(notificationServices.notificationHandler);
    //handle notification tap event when app is opened from terminated state
    notificationServices.handleNotificationInAppTerminatedState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Notifications'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            String? deviceToken = await notificationServices.getToken();
            await notificationServices.sendPushNotification(
                title: 'Test',
                body: 'This is test notification',
                payload: 'testPayload',
                token: deviceToken!);
          },
          child: const Text('Send Notification'),
        ),
      ),
    );
  }
}
