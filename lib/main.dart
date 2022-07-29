import 'package:app_grupohdi/pages/LoginPage.dart';
import 'package:flutter/material.dart';

import 'services/NotificationService.dart';

void main() {
  // to ensure all the widgets are initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // to initialize the notificationservice.
  NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      // home: PontoPage(),
    );
  }
}
