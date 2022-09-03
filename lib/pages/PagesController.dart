import 'package:app_grupohdi/components/ChangeThemeButtonWidget.dart';
import 'package:app_grupohdi/pages/HomePage.dart';
import 'package:app_grupohdi/pages/LoginPage.dart';
import 'package:app_grupohdi/pages/PontoPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'NavigationDraweWidget.dart';

class PagesController extends StatefulWidget {
  final int pageID;
  const PagesController(this.pageID);

  @override
  _PagesControllerState createState() => _PagesControllerState();
}

class _PagesControllerState extends State<PagesController> {
  List pageTitle = ["Home", "Bater Ponto", "Settings"];
  int _page = 0;
  bool alreadyLogged = false;
  final GlobalKey _bottomNavigationKey = GlobalKey();
  final sideMenuKey = GlobalKey<ScaffoldState>();

  Widget bodyFunction() {
    switch (_page) {
      case 0:
        return const HomePage();
      case 1:
        return const PontoPage();
      default:
        return LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Logado: $alreadyLogged e ${widget.pageID.toInt()} ");
    if (!alreadyLogged && widget.pageID < 0) {
      return LoginPage();
    } else {
      return Scaffold(
        key: sideMenuKey,
        endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            pageTitle[_page],
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
          actions: const [ChangeThemeButtonWidget()],
          centerTitle: true,
        ),
        body: bodyFunction(),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            const Icon(Icons.home, size: 30),
            const Icon(Icons.access_time_outlined, size: 30),
            // Icon(Icons.more_horiz, size: 30),
            buildDrawerButtonMenu(
                icon: Icons.more_horiz,
                size: 30,
                onClicked: () {
                  // Scaffold.of(sideMenuKey).openEndDrawer();
                  sideMenuKey.currentState!.openEndDrawer();
                }),
          ],
          color: Colors.cyan.shade200,
          buttonBackgroundColor: Colors.grey.shade200,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 200),
          onTap: (index) {
            // if (index == 2) {
            //   _scaffoldKey.currentState?.openDrawer();
            // }
            setState(() {
              _page = index;
            });
          },
        ),
      );
    }
  }

  Widget buildDrawerButtonMenu({
    required IconData icon,
    required double size,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
        size: size,
      ),
      onTap: onClicked,
    );
  }
}
