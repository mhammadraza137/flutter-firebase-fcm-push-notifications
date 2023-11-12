import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fcm_push_notifications/screens/home_screen.dart';
import 'firebase_options.dart';

// must be a top level getter
@pragma('vm:entry-point')
Future<void> onBackgroundMessageHandler(RemoteMessage? message) async {
log('background message handler called.............');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // called when notification is received in background or app terminated state
  FirebaseMessaging.onBackgroundMessage(onBackgroundMessageHandler);
  runApp(const MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: const HomeScreen(),
    );
  }
}
