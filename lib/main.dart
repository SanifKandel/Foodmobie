import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:foodreminder/helper/objectbox.dart';
import 'package:foodreminder/state/objectbox_state.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ObjectBoxInstance.deleteDatabase();
  ObjectBoxState.objectBoxInstance = await ObjectBoxInstance.init();
  // ObjectBoxState.objectBoxInstance?.objectBoxInstance?._store?.close();

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]).then(
  //   (value) =>
  //   ),
  // );
  AwesomeNotifications().initialize(
    'resource://drawable/playstore',
    [
      NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notification',
          channelDescription: 'Notification channel for basic',
          defaultColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.Max,
          ledColor: Colors.white,
          channelShowBadge: true),
    ],
  );
  runApp(const MyApp());
}
