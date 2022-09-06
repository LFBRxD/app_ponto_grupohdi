import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for date format
import 'package:slide_digital_clock/slide_digital_clock.dart';

import '../core/API.dart';
import '../entitys/Batidas.dart';
import '../services/NotificationService.dart';

class PontoPage extends StatefulWidget {
  final String token;

  const PontoPage({Key? key, required this.token}) : super(key: key);

  @override
  _PontoPageState createState() => _PontoPageState();
}

class _PontoPageState extends State<PontoPage> {
  bool canHit = true;

  @override
  void initState() {
    super.initState();
    print('token na tela de ponto : ${widget.token}');
  }

  late Future<Batidas> batidasFuture = API.getPointHits(widget.token);

  List<String> tiposBatida = [
    'Inicio de expediente',
    'Almoço',
    'Retorno Almoço',
    'Fim de expediente',
    'Batida extra'
  ];

  getCustomFormattedDateTime(String givenDateTime, String dateFormat) {
    // dateFormat = 'MM/dd/yy';
    final DateTime docDateTime = DateTime.parse(givenDateTime);
    return DateFormat(dateFormat).format(docDateTime);
  }

  Widget buildPointHits(Batidas batidas) => ListView.builder(
      itemCount: batidas.hit?.length,
      itemBuilder: (context, index) {
        final bat = batidas.hit![index];
        print(getCustomFormattedDateTime(bat.createdAt.toString(), 'MM/dd/yy'));
        return Card(
          child: ListTile(
            // leading: const CircleAvatar(
            //     // backgroundImage: AssetImage(tituloBatida[1]),
            //     ),
            title: Text(tiposBatida[index >= 5 ? 4 : index]),
            subtitle: Text(
                getCustomFormattedDateTime(bat.createdAt.toString(), 'HH:mm')),
          ),
        );
      });

  Widget buildButtonPointHit(bool canHit) {
    if (canHit) {
      return IconButton(
        icon: const Icon(Icons.fingerprint),
        iconSize: 120,
        onPressed: () async {
          var a = await batidasFuture;
          API
              .saveBatidaDePonto(widget.token)
              .whenComplete(() => {
                    NotificationService().showNotificationPointRegistered(
                        0, 'Ponto registrado!', ""),
                  })
              .then((value) => {
                    setState(() {
                      debugPrint("o click do botão");
                    })
                  });
        },
      );
    } else {
      return const ElevatedButton(
        onPressed: null,
        child: Text('Tenha um bom descanço'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade500,
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    height: 150.0,
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
