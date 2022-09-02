import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../entitys/Batidas.dart';

class API {
  static const _baseURL = "http://192.168.3.20:8000/api";

  static Future<List<Batidas>> getChecksFromCurUser(String tokenJWT) async {
    //var request = http.Request('GET', Uri.parse("${baseURL}/pointhits"));
    var request = http.Request(
        'GET', Uri.parse('http://192.168.3.20:8000/api/pointhits'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }

    var body = json.decode(response.stream.bytesToString().toString());
    debugPrint(body);
    return body.map((e) => Batidas.fromJson(e)).toList();
  }

  static Future saveBatidaDePonto(String tokenJWT) async {
    var url = Uri.parse("${_baseURL}/pointhits");
    final response = await http.post(url);
    return response.statusCode;
  }
}
