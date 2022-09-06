import 'dart:convert';

import 'package:app_grupohdi/core/UserPreferencesManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import '../entitys/Batidas.dart';
import 'GhdiAppConstants.dart';

class API {
  static const _baseURL = "http://192.168.3.20:8000/api";

  static Future<List<Batidas>> getChecksFromCurUser(String tokenJWT) async {
    //var request = http.Request('GET', Uri.parse("${baseURL}/pointhits"));
    var request = http.Request(
        'GET', Uri.parse('${GhdiAppConstants.API_URL}/api/pointhits'));

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

  static Future<Batidas> getPointHits(String token) async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    Map<String, String> queryParameters = {
      'Accept': '*/*',
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${token}',
      "user_id": decodedToken['sub']
    };

    var response = await http.get(
        Uri.parse("${GhdiAppConstants.API_URL}/api/pointhits"),
        headers: queryParameters);
    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> body = json.decode(response.body);
      return Batidas.fromJson(body);
    }
    return Batidas();
  }

  static Future saveBatidaDePonto(String token) async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    var headers = {
      "Accept": "application/json",
      "Content-type": "application/json",
      "Authorization": "Bearer ${token}"
    };
    Map data = {
      "userid": decodedToken['sub'],
    };
    var body = json.encode(data);
    var response = await http.post(
        Uri.parse("${GhdiAppConstants.API_URL}/api/pointhits"),
        headers: headers,
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    }

    Future<String> loginNoContext(String token) async {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      decodedToken.forEach((k, v) => print("got key $k with $v"));
      final email = UserPreferencesManager.getUserLogin();
      var headers = {
        "Accept": "application/json",
        "Content-type": "application/json",
      };
      Map data = {
        "email": email!,
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
  }
}
