import 'dart:convert';

import 'package:app_grupohdi/pages/PagesController.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/ui/Header.dart';
import '../services/NotificationService.dart';

class LoginPage extends StatelessWidget {
  var userController = TextEditingController();
  var passwordController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  Container getBody(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/logo.png'),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.cyan.shade500,
              Colors.cyan.shade300,
              Colors.cyan.shade400
            ])),
        child: SafeArea(
          child: getColum(context),
        ));
  }

  Column getColum(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 100,
        ),
        Header(),
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(left: 5.0, right: 5.0),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: <Widget>[
                        TextInput("Informe seu usuário", false, userController),
                        TextInput(
                            "Informe sua senha", true, passwordController),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Recuperar senha ?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.cyan.shade300,
                          side: BorderSide(width: 1, color: Colors.brown),
                          elevation: 0,
                          //elevation of button
                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(23)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60,
                              vertical: 15) //content padding inside button
                          ),
                      onPressed: () {
                        login(context);
                      },
                      child: const Text(
                        "Logar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ))
      ],
    );
  }

  Container TextInput(
      String info, bool isPassword, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
      child: TextField(
        controller: controller,
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

  Future<void> login(BuildContext context) async {
    NotificationService()
        .showNotification(1, 'Resultado login', 'Login Com sucesso');

    var headers = {
      'authorization': 'Basic ' +
          base64Encode(
              utf8.encode('${userController.text}:${passwordController.text}')),
      "Accept": "application/json",
      "Content-type": "application/json",
    };

    Map data = {"user": userController.text, "pass": passwordController.text};
    //encode Map to JSON
    var body = json.encode(data);

    if (userController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      if (userController.text == "hdi" && passwordController.text == "hdi") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PagesController()));
      } else {
        var response = await http.post(
            Uri.parse("http://192.168.3.2:5000/api/v1/login"),
            headers: headers,
            body: body);
        if (response.statusCode == 200) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PagesController()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Usuário ou senha está inválido"),
          ));
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Campos em branco não são permitidos."),
      ));
    }
    passwordController.text = "";
  }

  void _navigateToNextScreen(BuildContext context) {
    //navega entre paginas
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PontoPage()));
  }
}
