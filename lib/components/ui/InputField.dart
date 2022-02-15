import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextInput("Informe seu usuário", false),
        TextInput("Informe sua senha", true),
      ],
    );
  }

  Container TextInput(String info, bool isPassword) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
      child: TextField(
        obscureText: isPassword,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: info,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
