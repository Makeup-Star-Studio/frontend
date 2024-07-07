import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:makeupstarstudio/src/config/global_config.dart';
import 'package:makeupstarstudio/src/services/jwt_service.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';

class StarStudioApiService {
  final SharedPreferencesService sharedPref = SharedPreferencesService();

  Future<dynamic> get(String path, {bool isContainBaseUrl = true}) async {
    var token = await sharedPref.getStringPref('userData');
    String fullPath = isContainBaseUrl ? '${GlobalConfig.baseUrl}$path' : path;

    if (token != null && token['token'] != null) {
      String tokenString = token['token'];
      bool isExpired = JwtDecoder.isExpired(tokenString);
      var remainingTime = JwtDecoder.getRemainingTime(tokenString);

      print('isExpired: $isExpired');
      print('remaining time: $remainingTime');
      print('token: $tokenString');

      if (isExpired) {
        throw Exception('Session expired');
      }
    }

    print('Full Url ----> $fullPath');
    final response = await http.get(
      Uri.parse(fullPath),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        if (token != null && token['token'] != null)
          HttpHeaders.authorizationHeader: 'Bearer ${token['token']}',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load data: ${response.reasonPhrase}');
    }
  }

  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    var token = await sharedPref.getStringPref('userData');

   
    if (token != null && token['token'] != null) {
      String tokenString = token['token'];
      bool isExpired = JwtDecoder.isExpired(tokenString);
      var remainingTime = JwtDecoder.getRemainingTime(tokenString);

      print('isExpired: $isExpired');
      print('remaining time: $remainingTime');
      print('token: $tokenString');

      if (isExpired) {
        throw Exception('Session expired');
      }
    }

    print('Full Url ----> ${GlobalConfig.baseUrl}$path');
    final response = await http.post(
      Uri.parse('${GlobalConfig.baseUrl}$path'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        if (token != null && token['token'] != null)
          HttpHeaders.authorizationHeader: 'Bearer ${token['token']}',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load data: ${response.reasonPhrase}');
    }
  }
}
