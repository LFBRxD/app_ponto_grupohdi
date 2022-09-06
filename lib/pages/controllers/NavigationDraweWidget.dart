import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/ChangeThemeButtonWidget.dart';
import '../../core/UserPreferencesManager.dart';
import '../UserInfoPage.dart';
import 'PagesController.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  final String token;
  const NavigationDrawerWidget({Key? key, required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const name = 'Flavio Ramos';
    const email = 'framos@grupohdi.com';
    const funcao = 'Automatizador de testes';
    const urlImage =
        'https://media-exp1.licdn.com/dms/image/C4D03AQFgykctXRIXGg/profile-displayphoto-shrink_800_800/0/1661021625428?e=2147483647&v=beta&t=1_Cda0idyaHT1djzDb311_VgGC05rIfWCcQ2yyFqasQ';

    return Drawer(
      child: Material(
        color: Colors.blue.shade300,
        child: ListView(
          // padding: padding,
          children: <Widget>[
            buildHeader(
                urlImage: urlImage,
                name: name,
                email: email,
                function: funcao,
                onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        const UserInfoPage(name: name, urlImage: urlImage)))),
            Container(
                padding: padding,
                child: Column(children: [
                  const Divider(
                    color: Colors.white70,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  // buildMenuItem(
                  //   text: 'Funcao 1',
                  //   icon: Icons.people,
                  //   onClicked: () => selectedItem(context, 0),
                  // ),
                  buildMenuItem(
                    text: 'Holerite',
                    icon: Icons.account_box_outlined,
                  ),
                  buildMenuItem(
                    text: 'Ver relatório mês',
                    icon: Icons.calendar_month_outlined,
                  ),
                  buildMenuItem(
                    text: 'Contato do gestor',
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
                    text: 'Settings',
                    icon: Icons.settings,
                  ),
                  buildMenuItem(
                    text: 'Notifications',
                    icon: Icons.notifications_none_outlined,
                  ),
                  buildMenuItem(
                    text: 'Logoff',
                    icon: Icons.logout_rounded,
                    onClicked: () => doLogoff(context, token),
                  ),
                  const Divider(
                    color: Colors.white70,
                  ),
                  const Text('Dark mode'),
                  const ChangeThemeButtonWidget(),
                ])),
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
            builder: (builder) => const UserInfoPage(
              name: 'Flavio Ramos',
              urlImage:
                  'https://media-exp1.licdn.com/dms/image/C4D03AQFgykctXRIXGg/profile-displayphoto-shrink_800_800/0/1661021625428?e=2147483647&v=beta&t=1_Cda0idyaHT1djzDb311_VgGC05rIfWCcQ2yyFqasQ',
            ),
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

  void doLogoff(BuildContext context, String token) {
    UserPreferencesManager.clearUserDataFromSavedLogin();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PagesController(
                  pageID: -1,
                  token: token,
                )));
  }

  buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required String function,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(urlImage),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        email,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                    child: Icon(
                      Icons.add_comment_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    function,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
