import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:makeupstarstudio/features/admin/screens/main/admin_main_page.dart';
import 'package:makeupstarstudio/src/api/login_model.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';

class LoginProvider with ChangeNotifier {
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

      // Check the response status
      if (response.statusCode == 200) {
        // Print the response body for debugging
        print('Response body: ${response.body}');

        // Parse the response
        var responseData = json.decode(response.body);
        var apiResponse = LoginModel.fromJson(responseData);

        // Debugging the token
        print('Retrieved token: ${apiResponse.token}');

        if (apiResponse.token != null && apiResponse.token!.isNotEmpty) {
          await sharedPrefs.setStringPref('userData', response.body);
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
      } else {
        throw 'Server error: ${response.statusCode}';
      }
    } catch (e, s) {
      Navigator.of(context).pop();

      print('Error: $e');
      print('Stack trace: $s');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
