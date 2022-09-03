import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:slide_digital_clock/slide_digital_clock.dart';

import '../core/API.dart';
import '../entitys/Batidas.dart';
import '../services/NotificationService.dart';

class PontoPage extends StatefulWidget {
  const PontoPage({Key? key}) : super(key: key);
  @override
  _PontoPageState createState() => _PontoPageState();
}

class _PontoPageState extends State<PontoPage> {
  bool canHit = true;
  Future<Batidas> batidasFuture = getPointHits();

  static Future<Batidas> getPointHits() async {
    // return API.getChecksFromCurUser("tokenJWT");
    var url = Uri.parse('http://192.168.3.20:8000/api/pointhits');
    final response = await http.get(url);
    Map<String, dynamic> body = json.decode(response.body);
    return Batidas.fromJson(body);
  }

  Widget buildButtonPointHit(bool canHit) {
    if (canHit) {
      return ElevatedButton(
        onPressed: () async {
          debugPrint("metodo chamado");
          var a = await batidasFuture;
          API
              .saveBatidaDePonto("tokenJWT")
              .whenComplete(() => {
                    NotificationService()
                        .showNotification(0, 'Ponto registrado', ""),
                  })
              .then((value) => {
                    setState(() {
                      debugPrint("o click do botão");
                    })
                  });
        },
        child: const Text('Registrar Batida'),
      );
    } else {
      return const ElevatedButton(
        onPressed: null,
        child: Text('Tenha um bom descanço'),
      );
    }
  }

  Widget buildPointHits(Batidas batidas) => ListView.builder(
      itemCount: batidas.hit?.length,
      itemBuilder: (context, index) {
        final bat = batidas.hit![index];
        return Card(
          child: ListTile(
            leading: const CircleAvatar(
                // backgroundImage: AssetImage(tituloBatida[1]),
                ),
            title: Text("${index}"),
            subtitle: Text(bat.createdAt.toString()),
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade500,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.cyan.shade500,
        title: const Text(
          "Ponto",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
            width: double.infinity,
            height: 800,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      alignment: Alignment.center,
                      height: 70.0,
                      width: double.infinity,
                      // color: Colors.yellow,
                      child: Column(
                        children: [
                          DigitalClock(
                            digitAnimationStyle: Curves.elasticInOut,
                            is24HourTimeFormat: true,
                            areaDecoration:
                                const BoxDecoration(color: Colors.transparent),
                            hourMinuteDigitTextStyle: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 50,
                            ),
                          )
                        ],
                      )),
                ),
                Expanded(
                  child: FutureBuilder<Batidas>(
                    future: batidasFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        var pointHits = snapshot.data!;
                        return buildPointHits(pointHits);
                      } else {
                        return const Text("Não houveram batidas hoje");
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.center,
                    height: 75.0,
                    width: double.infinity,
                    // color: Colors.blue,
                    child: buildButtonPointHit(canHit),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
