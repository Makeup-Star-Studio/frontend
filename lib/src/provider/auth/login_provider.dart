import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/src/api/api_service.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';

class LoginProvider with ChangeNotifier {
  Future<void> loginUser(
      BuildContext context, String username, String password) async {
    final HttpRepo _httpRepo = HttpServices();
    final SharedPreferencesService _sharedPrefs = SharedPreferencesService();

    try {
     
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(
                color: Colors.black,
              ),
              SizedBox(width: 20),
              Text('Logging in...'),
            ],
          ),
        ),
      );

      Map<String, String> body = <String, String>{
        'username': username,
        'password': password,
      };

 
      var response = await _httpRepo.post(ApiConstant.adminLoginUri, body);

      print('Response body: ${response.data}');

  
      Navigator.of(context).pop();

      if (response != null && response.token != null) {

        await _sharedPrefs.setStringPref('userData', response.toJson());
        await _sharedPrefs.setBoolPref('logged', true);

    
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Successful'),
            duration: Duration(seconds: 2),
          ),
        );

       
        Navigator.pushNamed(context, WebsiteRoute.admindahboard);
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
