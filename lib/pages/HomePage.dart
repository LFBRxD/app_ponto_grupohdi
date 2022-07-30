import 'package:app_grupohdi/services/NotificationService.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const fetchBackground = "fetchBackground";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade500,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.cyan.shade500,
        title: const Text(
          "Home",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          height: 800,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Row(
            children: [
              Expanded(
                /*1*/
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        debugPrint("metodo chamado");
                        NotificationService().showNotification(
                            1,
                            'Notification_title.text',
                            'Notification_descrp.text');
                      },
                      child: new Text('Show local'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        debugPrint("metodo chamado2");
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
                ),
              ),
              /*3*/
              Icon(
                Icons.star,
                color: Colors.red[500],
              ),
              const Text('41'),
            ],
          ),
        ),
      ),
    );
  }
}
