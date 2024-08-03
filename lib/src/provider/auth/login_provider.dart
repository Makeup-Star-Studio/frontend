import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:makeupstarstudio/features/admin/screens/main/admin_main_page.dart';
import 'package:makeupstarstudio/src/api/login_model.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';

class LoginProvider with ChangeNotifier {
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> loginUser(BuildContext context, String username, String password) async {
    final SharedPreferencesService sharedPrefs = SharedPreferencesService();

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const AlertDialog(
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

      final response = await http.post(
        Uri.parse('http://localhost:3001/admin/login/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        var responseData = json.decode(response.body);
        var apiResponse = LoginModel.fromJson(responseData);

        print('Retrieved token: ${apiResponse.token}');

        if (apiResponse.token != null && apiResponse.token!.isNotEmpty) {
          await sharedPrefs.setStringPref('userToken', apiResponse.token);
          await sharedPrefs.setBoolPref('logged', true);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login Successful'),
              duration: Duration(seconds: 2),
            ),
          );

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AdminPage(selectedIndex: 0)),
          );
        } else {
          throw 'Invalid response from server';
        }
      } else if (response.statusCode == 401) {
        _errorMessage = 'Invalid credentials. Please type the correct one.';
        notifyListeners(); 
      } else {
        _errorMessage = 'Server error: ${response.statusCode}';
        notifyListeners(); 
      }
    } catch (e, s) {
      Navigator.of(context).pop();
      _errorMessage = 'An unexpected error occurred';
      notifyListeners(); 
      print('Error: $e');
      print('Stack trace: $s');
    }
  }

    Future<void> checkLoginStatus(BuildContext context) async {
    final SharedPreferencesService sharedPrefs = SharedPreferencesService();
    bool isLogged = await sharedPrefs.getBoolPref('logged') ?? false;

    if (isLogged) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AdminPage(selectedIndex: 0)),
      );
    }
  }
}
