import 'package:app_grupohdi/pages/HomePage.dart';
import 'package:app_grupohdi/pages/LoginPage.dart';
import 'package:app_grupohdi/pages/PontoPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'SettingsPage.dart';

class PagesController extends StatefulWidget {
  @override
  _PagesControllerState createState() => _PagesControllerState();
}

class _PagesControllerState extends State<PagesController> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  Widget bodyFunction() {
    switch (_page) {
      case 0:
        return const HomePage();
      case 1:
        return const PontoPage();
      case 2:
        return const SettingsPage();
      default:
        return LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyFunction(),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.access_time_outlined, size: 30),
          Icon(Icons.settings, size: 30),
        ],
        color: Colors.cyan.shade200,
        buttonBackgroundColor: Colors.grey.shade200,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 200),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}
