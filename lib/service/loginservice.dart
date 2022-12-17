import 'dart:convert';
import 'dart:io';

import 'global.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static Future<http.Response> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
      "device_name": "android",
    };
    var body = json.encode(data);
    var url = Uri.parse(baseUrl + 'auth/login');

    final header1 = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Access-Control_Allow_Origin": "*"
    };

    http.Response response = await http.post(
      url,
      headers: header1,
      body: body,
    );

    Map<String, dynamic> responseJson = json.decode(response.body);

    // save token use shared preferences
    if (response.statusCode == 200) {
      SharedPreferences sp = await SharedPreferences.getInstance();

      sp.setString("token", responseJson['token']);

      print(sp.getString("token"));
    }

    return response;
  }

  static Future<http.Response> logout() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    String? token = sp.getString("token");

    var url = Uri.parse(baseUrl + 'auth/logout');

    final header = {
      'Authorization': 'Bearer $token',
    };

    http.Response response = await http.post(
      url,
      headers: header,
    );

    sp.remove("token");

    return response;
  }

  static Future<http.Response> register(
      String name, String email, String password) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": password,
      "device_name": "android",
    };
    var body = json.encode(data);
    var url = Uri.parse(baseUrl + 'auth/register');

    final header1 = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Access-Control_Allow_Origin": "*"
    };

    http.Response response = await http.post(
      url,
      headers: header1,
      body: body,
    );

    return response;
  }
}
