import 'package:app_grupohdi/services/NotificationService.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const fetchBackground = "fetchBackground";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          height: 800,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            children: [
              /*2*/
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: const Text(
                  'Oeschinen Lake ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Kandersteg, ',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  NotificationService().showNotification(
                      50, 'Notificação rápida', 'Corpo da notificação');
                },
                child: new Text('Show local'),
              ),
              ElevatedButton(
                onPressed: () async {
                  NotificationService().scheduleNotification();
                },
                child: new Text('CShow Scheduled'),
              ),
              ElevatedButton(
                onPressed: () => {
                  // callbackDispatcher(),
                  Workmanager().registerOneOffTask(
                      "notificationCallBack", "notificationCallBack",
                      constraints:
                          Constraints(networkType: NetworkType.connected),
                      initialDelay: Duration(seconds: 60)),
                },
                child: new Text('Show with payload'),
              ),
            ],
          )),
    );
  }
}
