import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'PeoplePage.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.blue.shade300,
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 48,
            ),
            buildMenuItem(
              text: 'Funcao 1',
              icon: Icons.people,
              onClicked: () => selectedItem(context, 0),
            ),
            buildMenuItem(
              text: 'Funcao 2',
              icon: Icons.account_box_outlined,
            ),
            buildMenuItem(
              text: 'Funcao 3',
              icon: Icons.add_alarm_outlined,
            ),
            buildMenuItem(
              text: 'Funcao 4',
              icon: Icons.add_call,
            ),
            const SizedBox(
              height: 24,
            ),
            const Divider(
              color: Colors.white70,
            ),
            const SizedBox(
              height: 24,
            ),
            buildMenuItem(
              text: 'Funcao 3',
              icon: Icons.account_tree_outlined,
            ),
            buildMenuItem(
              text: 'Notifications',
              icon: Icons.notifications_none_outlined,
            ),
          ],
        ),
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (builder) => PeoplePage(),
          ));
          break;
        }
    }
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: const TextStyle(color: color),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
