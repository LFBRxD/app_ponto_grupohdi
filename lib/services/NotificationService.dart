import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static String _MAIN_CHANNEL = 'Main Channel';
  static String _COMUNICATION_CHANNEL = 'Comunication Channel';
  static String _POINTHIT_CHANNEL = 'PointHit Channel';

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    // Android initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // ios initialization
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    // the initialization settings are initialized after they are setted
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(int id, String title, String body) async {
    await flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        const NotificationDetails(
          // Android details
          android: AndroidNotificationDetails(
            'main_channel_1', 'Main Channel',
            channelDescription: "ashwin",
            importance: Importance.max,
            priority: Priority.high,
            color: Colors.red,
            sound: RawResourceAndroidNotificationSound('audio1'),
            // playSound: true
          ),
          // iOS details
          iOS: IOSNotificationDetails(
            sound: 'default.wav',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ));
  }

  Future<void> scheduleNotification() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));

    var currentDateTime = tz.TZDateTime.now(tz.getLocation('America/Sao_Paulo'))
        .add(const Duration(seconds: 10));
    await flutterLocalNotificationsPlugin.zonedSchedule(
      5,
      "Notificaçao agendada",
      "Bater o ponto em 10 minutos",
      currentDateTime, //schedule the notification to show after 2 seconds.
      const NotificationDetails(
        // Android details
        android: AndroidNotificationDetails(
            'main_channel_delayed', 'Main Channel',
            channelDescription: "ashwin",
            importance: Importance.high,
            priority: Priority.max,
            color: Colors.blue,
            sound: RawResourceAndroidNotificationSound('audio1'),
            playSound: true),
        // iOS details
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),

      // Type of time interpretation
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle:
          true, // To show notification even when the app is closed
    );
  }
}
