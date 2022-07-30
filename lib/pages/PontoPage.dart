import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:slide_digital_clock/slide_digital_clock.dart';

import '../entitys/Registroponto.dart';
import '../services/NotificationService.dart';

class PontoPage extends StatefulWidget {
  const PontoPage({Key? key}) : super(key: key);

  @override
  _PontoPageState createState() => _PontoPageState();
}

class _PontoPageState extends State<PontoPage> {
  late Future<Map<String, dynamic>> data = pegarPontos();
  static String hora = "";

  static const List<String> tituloBatida = [
    "Entrada",
    "Almoço",
    "Retorno",
    "Saida"
  ];

  static List<Registroponto> getChecks() {
    const data = [
      {
        "id": "62e441dda286112413683f1c",
        "guid": "1adb789a-4eba-4a9d-a1cf-85dd8f0549e2",
        "podeBater": true,
        "batidas": [
          {"id": 0, "dataRegistro": "2022-07-29T05:23:57 +03:00"},
          {"id": 1, "dataRegistro": "2022-07-29T05:23:57 +03:00"},
          {"id": 2, "dataRegistro": "2022-07-29T05:23:57 +03:00"}
        ]
      }
    ];
    return data.map<Registroponto>(Registroponto.fromJson).toList();
  }

  Future<Map<String, dynamic>> pegarPontos() async {
    var url = Uri.parse("https://ghdi.servicoqa.com/");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> d = json.decode(response.body);
      return d;
    } else {
      throw Exception("Erro ao carregar os dados");
    }
  }

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
                                BoxDecoration(color: Colors.transparent),
                            hourMinuteDigitTextStyle: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 50,
                            ),
                          )
                        ],
                      )),
                ),
                Expanded(
                  child: criarEntradasESaidas(getChecks()),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.center,
                    height: 75.0,
                    width: double.infinity,
                    // color: Colors.blue,
                    child: ElevatedButton(
                      onPressed: () async {
                        debugPrint("metodo chamado");
                        NotificationService().showNotification(
                            1,
                            'Ponto registrado',
                            'Sua marcação foi realizada com sucesso');
                      },
                      child: const Text('Registrar Batida'),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  ListView criarEntradasESaidas(List<Registroponto> batidas) {
    return ListView.builder(
      itemBuilder: (BuildContext, index) {
        var b = batidas.single.batidas[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(tituloBatida[index]),
            ),
            title: Text(tituloBatida[index]),
            subtitle: Text(b.dataRegistro),
          ),
        );
      },
      itemCount: batidas.single.batidas.length,
      shrinkWrap: true,
      padding: EdgeInsets.all(5),
      scrollDirection: Axis.vertical,
    );
  }
}
