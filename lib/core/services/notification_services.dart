
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../../fileExport.dart';

class NotificationServices {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  String channelId = 'channelBored';
  static const channelGroupId = 'boredNotificationGroupID';
  static const AndroidNotificationChannelGroup androidNotificationChannelGroup =
      AndroidNotificationChannelGroup(
          channelGroupId, 'boredNotificationGroupID',
          description: 'Grouped notifications for Bored.');
  Future<void> initListener() async {
    try {
      const InitializationSettings initializationSettingsAndroid =
          InitializationSettings(
              android: AndroidInitializationSettings('@mipmap/ic_launcher'),iOS: DarwinInitializationSettings());
     await flutterLocalNotificationsPlugin.initialize(
        initializationSettingsAndroid,
        onDidReceiveNotificationResponse: (details) {
          if (details.input != null) {
            Logger().t(details.input);
          }
        },
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannelGroup(androidNotificationChannelGroup);

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(const AndroidNotificationChannel(
              'channelBored', 'channelBored',
              description: 'Notification channel for Bored.',
              groupId: channelGroupId));

              if (Platform.isAndroid) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
    AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
              }else{
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
    IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
    );
    }

    } catch (e) {
      print('error in init notifications$e');
    }
  }

  void ss(String title,String body,DateTime dateTime)async{
    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        tz.TZDateTime.from(dateTime,tz.local),
        const NotificationDetails(
            android: AndroidNotificationDetails(
            'channelBored', 'channelBored',
                channelDescription: 'Notification channel for Bored.'),
          iOS: DarwinNotificationDetails(presentAlert: true,presentSound: true),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);

  }



}


