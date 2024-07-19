import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:makeupstarstudio/features/admin/screens/main/admin_main_page.dart';
import 'package:makeupstarstudio/src/api/api_service.dart';
import 'package:makeupstarstudio/src/api/response_model.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';

class LoginProvider with ChangeNotifier {
Future<void> loginUser(BuildContext context, String username, String password) async {
  final HttpRepo httpRepo = HttpServices();
  final SharedPreferencesService sharedPrefs = SharedPreferencesService();

  try {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(color: Colors.black),
            SizedBox(width: 20),
            Text('Logging in...'),
          ],
        ),
      ),
    );

    Map<String, String> body = {
      'username': username,
      'password': password,
    };

    var response = await httpRepo.post("http://localhost:3001/admin/login/", body);

    print('Response body: ${response.data}');

    Navigator.of(context).pop();

    var apiResponse = ApiResponse.fromJson(response.data);

    if (apiResponse.token != null && apiResponse.token!.isNotEmpty) {
      await sharedPrefs.setStringPref('userData', json.encode(response.data));
      await sharedPrefs.setBoolPref('logged', true);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Successful'),
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => AdminPage()),
      );
    } else {
      throw 'Invalid response from server';
    }
  } catch (e, s) {
    Navigator.of(context).pop();

    print('Error: $e');
    print('Stack trace: $s');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: ${e.toString()}'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

}
