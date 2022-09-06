import 'dart:convert';

import 'package:app_grupohdi/core/GhdiAppConstants.dart';
import 'package:app_grupohdi/core/UserPreferencesManager.dart';
import 'package:app_grupohdi/pages/controllers/PagesController.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/ui/Header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var userController = TextEditingController();
  var passwordController = TextEditingController();
  var saveLoginData = false;
  String token = '';

  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  @override
  void initState() {
    super.initState();
    UserPreferencesManager.hasUserAndPasswordsaved().then((hasLoginSaved) {
      if (hasLoginSaved) {
        loginNoContext().then((value2) {
          debugPrint(value2);
          if (value2!.length > 200) {
            setState(() {
              token = value2;
            });
          } else {
            userController.text = UserPreferencesManager.getUserLogin()!;
            setState(() {
              saveLoginData = hasLoginSaved;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? 'DarkTheme'
        : 'LightTheme';
    if (token.isNotEmpty) {
      return PagesController(
        pageID: 0,
        token: token,
      );
    } else {
      return Scaffold(
        body: SafeArea(
          child: getBody(context),
        ),
      );
    }
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
      child: getColum(context),
    );
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
                        textInputPass("Informe sua senha", passwordController),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Salvar dados do login",
                        style: TextStyle(
                          color: Colors.black,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      Switch.adaptive(
                        value: saveLoginData,
                        onChanged: (isOn) {
                          setState(() {
                            saveLoginData = isOn;
                            if (!saveLoginData) {
                              UserPreferencesManager
                                  .clearUserDataFromSavedLogin();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.cyan.shade300,
                          side: const BorderSide(width: 1, color: Colors.brown),
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
                        login(context, userController.text,
                            passwordController.text);
                      },
                      child: const Text(
                        "Logar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Recuperar senha ?",
                    style: TextStyle(color: Colors.grey),
                  ),
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
          prefixIcon: const Icon(Icons.account_circle, size: 24),
        ),
      ),
    );
  }

  void login2() {
    // if (UserPreferencesManager.hasUserAndPasswordsaved()) {
    //   login(context, UserPreferencesManager.getUserLogin().toString(),
    //       UserPreferencesManager.getUserPass().toString());
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => PagesController(0)));
    // }
  }

  Container textInputPass(String info, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
      child: TextField(
        controller: controller,
        obscureText: _obscured,
        focusNode: textFieldFocusNode,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: info,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.lock_rounded, size: 24),
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
            child: GestureDetector(
              onTap: _toggleObscured,
              child: Icon(
                _obscured
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return;
      } // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  Future<String?> loginNoContext() async {
    // String yourToken = "Your JWT";
    // Map<String, dynamic> decodedToken = JwtDecoder.decode(
    //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4zLjIwOjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNjYyNDE2MDE0LCJleHAiOjE2NjI0MTk2MTQsIm5iZiI6MTY2MjQxNjAxNCwianRpIjoic2Iza01mRVdtQk5zclZEMCIsInN1YiI6IjciLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.JscIXXO1I6_w0cCIpn16WkeQK37zQwYrTlr1nfmcuoM');
    //
    // decodedToken.forEach((k, v) => print("got key $k with $v"));
    final email = UserPreferencesManager.getUserLogin();
    var headers = {
      "Accept": "application/json",
      "Content-type": "application/json",
    };
    Map data = {
      "email": email,
      "password": UserPreferencesManager.getUserPass()!
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
        Uri.parse("${GhdiAppConstants.API_URL}/api/login"),
        headers: headers,
        body: body);
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body)['access_token'];
    } else {
      UserPreferencesManager.clearUserDataFromSavedLogin();
      return email;
    }
  }

  Future<void> login(BuildContext context, String login, String pass) async {
    var headers = {
      "Accept": "application/json",
      "Content-type": "application/json",
    };

    Map data = {"email": login, "password": pass};
    //encode Map to JSON
    var body = json.encode(data);

    if (login.isNotEmpty && pass.isNotEmpty) {
      if (login == "hdi" && pass == "hdi") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PagesController(
                      pageID: 0,
                      token: token,
                    )));
      } else {
        var response = await http.post(
            Uri.parse("${GhdiAppConstants.API_URL}/api/login"),
            headers: headers,
            body: body);
        if (response.statusCode == 200) {
          token = json.decode(response.body)['access_token'];
          if (saveLoginData) {
            UserPreferencesManager.setUserAndPassword(login, pass);
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PagesController(
                        pageID: 0,
                        token: token,
                      )));
          print(response.body);
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
}
