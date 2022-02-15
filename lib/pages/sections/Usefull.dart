import 'package:app_grupohdi/components/ui/Button.dart';
import 'package:flutter/material.dart';

class Usefull extends StatelessWidget {
  const Usefull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: const <Widget>[
          Text(
            "Links uteis",
            style: TextStyle(
                fontSize: 23,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 50,
          ),
          Button(),
          SizedBox(
            height: 10,
          ),
          Button(),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
