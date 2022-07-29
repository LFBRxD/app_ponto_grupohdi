import 'dart:convert';

import 'package:app_grupohdi/pages/Clock.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PontoPage extends StatefulWidget {
  const PontoPage({Key? key}) : super(key: key);

  @override
  _PontoPageState createState() => _PontoPageState();
}

class _PontoPageState extends State<PontoPage> {
  late Future<Map<String, dynamic>> data = pegarPontos();

  Future<Map<String, dynamic>> pegarPontos() async {
    var url = Uri.parse("http://192.168.3.20:5000/api/v1/checks");
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
            child: Container(
              child: Column(children: [
                Clock(),
                criarEntradasESaidas("Entrada", ""),
                ElevatedButton(
                    onPressed: () {
                      print(data.then((value) => null));

                    },
                    child: null)
              ]),
            )),
      ),
    );
  }

  Row criarEntradasESaidas(String tipoBatida, String hora) {
    return Row(
      children: [
        Expanded(
          /*1*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*2*/
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  tipoBatida,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        Text(hora),
      ],
    );
  }
}
