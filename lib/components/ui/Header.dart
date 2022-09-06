import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          SizedBox(
            height: 50,
          ),
          // Center(
          //   child: Text(
          //     "Login",
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 40,
          //     ),
          //   ),
          // ),
          Center(
            child: Text(
              "Acesso somente para funcionarios",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
