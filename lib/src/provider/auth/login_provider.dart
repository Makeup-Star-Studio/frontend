import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/src/api/api_service.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';

class LoginProvider with ChangeNotifier {
  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    final HttpRepo _httpRepo = HttpServices();
    final SharedPreferencesService _sharedPrefs = SharedPreferencesService();

    try {
      // Show a loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('Logging in...'),
            ],
          ),
        ),
      );

      // Prepare the request body
      Map<String, String> body = <String, String>{
        'wallet_id': email,
        'wallet_pin': password,
      };

      // Make the API call
      var response = await _httpRepo.post(ApiConstant.adminLoginUri, body);

      // Dismiss the loading indicator
      Navigator.of(context).pop();

      // Handle successful login
      if (response != null && response.token != null) {
        // Save user data to SharedPreferences
        await _sharedPrefs.setStringPref('userData', response.toJson());
        await _sharedPrefs.setBoolPref('logged', true);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Successful'),
            duration: Duration(seconds: 2),
          ),
        );

        // Navigate to dashboard
        Navigator.pushNamed(context, WebsiteRoute.homeRoute);
      } else {
        // Handle case where response is not as expected
        throw 'Invalid response from server';
      }
    } catch (e, s) {
      // Catch and handle errors
      print('Error: $e');
      print('Stack trace: $s');

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
