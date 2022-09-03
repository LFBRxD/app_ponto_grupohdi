import 'package:flutter/material.dart';

import '../ChangeThemeButtonWidget.dart';

class CreateAppBarWidget extends StatefulWidget {
  @override
  State<CreateAppBarWidget> createState() => _CreateAppBarWidgetState();
}

class _CreateAppBarWidgetState extends State<CreateAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Theme.of(context).primaryColor,
      title: const Text(
        "Home",
        style: TextStyle(
          fontSize: 25,
        ),
      ),
      actions: [ChangeThemeButtonWidget()],
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }
}
