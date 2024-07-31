import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constant_finals.dart';
import 'package:http/http.dart' as http;

class ServiceHelper {
  Future service(String method, String endpoint, dynamic parameter,
      dynamic bodyForm) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token') ?? '-';
    String cookies = pref.getString('cookies') ?? '-';

    var header = {
      'X-RESTAPI-KEY': 'someKey',
      'Authorization': 'Bearer ' + token,
      'Cookie': cookies
    };
    var urlApi = "museum.uad.ac.id";
    var mod = "/index.php/auth/des/";

    var urlendpoint = mod + endpoint;
    dynamic url = Uri.https(urlApi, urlendpoint, parameter);

    if (method == 'post') {
      dynamic response = await http.post(url, body: bodyForm, headers: header);
      return response;
    } else {
      dynamic response = await http.get(url, headers: header);
      return response;
    }
  }
}
