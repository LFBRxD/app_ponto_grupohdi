import 'dart:async';

import 'package:app_grupohdi/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import 'services/NotificationService.dart';

void main() {
  // to ensure all the widgets are initialized.
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(callbackDispatcher);

  // to initialize the notificationservice.
  NotificationService().initNotification();
  runApp(const MyApp());
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case "notificationCallBack":
        print("notificationCallBack chamado");
        NotificationService().showNotification(1, 'callback notify',
            "notification com timer ${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}");
        break;
    }
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: LoginPage(),
      home: LoginPage(),
    );
  }
}
