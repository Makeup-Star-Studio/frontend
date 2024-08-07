import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/features/admin/screens/main/admin_main_page.dart';
import 'package:makeupstarstudio/src/api/api_services.dart';
import 'package:makeupstarstudio/src/model/response_model.dart';
import 'package:makeupstarstudio/src/model/user_model.dart';
import 'package:makeupstarstudio/src/provider/auth/check_login_provider.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  final SharedPreferencesService _sharedPrefs = SharedPreferencesService();
  int _failedAttempts = 0;
  DateTime? _lockoutTime;
  Timer? _lockoutTimer;
  String? _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<User> _user = [];
  List<User> get user => _user;

  String _id = '';
  String get id => _id;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  String? errorMessage;

  final StarStudioApiService _apiService = StarStudioApiService();

  Future<void> loadFailedAttempts() async {
    final prefs = await SharedPreferences.getInstance();
    _failedAttempts = prefs.getInt('failedAttempts') ?? 0;
    String? lockoutEndTimeStr = prefs.getString('lockoutTime');
    if (lockoutEndTimeStr != null) {
      _lockoutTime = DateTime.parse(lockoutEndTimeStr);
    }
  }

  Future<void> loginUser(
      BuildContext context, String username, String password) async {
    final SharedPreferencesService sharedPrefs = SharedPreferencesService();
    final prefs = await SharedPreferences.getInstance();
    const int maxAttempts = 5;
    const Duration lockoutDuration = Duration(minutes: 1);

    if (_lockoutTime != null && DateTime.now().isBefore(_lockoutTime!)) {
      _showLockoutDialog(context);
      return;
    }

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
        Uri.parse('${ApiConstant.localUrl}/api/admin/login/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      print('${ApiConstant.localUrl}/api/admin/login/');
      print('Response status: ${response.statusCode}');

      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        _failedAttempts = 0;
        await prefs.remove('failedAttempts');
        await prefs.remove('lockoutTime');

        var responseData = json.decode(response.body);
        var apiResponse = ApiResponse.fromJson(responseData);
        print('API Response: ${apiResponse.toJson()}');
        print('Retrieved token: ${apiResponse.token}');

        _id = responseData['data']['user']['id'];
        print('user ID: $_id'); // Add this line
        if (apiResponse.token.isNotEmpty) {
          await sharedPrefs.setStringPref('userToken', apiResponse.token);
          await sharedPrefs.setBoolPref('logged', true);

          context.read<CheckLoginProvider>().setLoggedIn(true);
          _isLoggedIn = true;
          notifyListeners();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login Successful'),
              duration: Duration(seconds: 2),
            ),
          );

          Navigator.pushNamed(context, '/admin');
        } else {
          _handleFailedAttempt(prefs, maxAttempts, lockoutDuration);
          _showErrorSnackBar(context, 'Invalid response from server');
        }
      } else if (response.statusCode == 401) {
        var responseData = json.decode(response.body);
        String errorMessage;
        if (responseData['error'] == 'username') {
          errorMessage = 'Username is not correct.';
        } else if (responseData['error'] == 'password') {
          errorMessage = 'Incorrect password. Please provide the correct one.';
        } else {
          errorMessage = 'Invalid credentials. Please try again.';
        }
        _handleFailedAttempt(prefs, maxAttempts, lockoutDuration);
        _showErrorSnackBar(context, errorMessage);
      } else {
        _errorMessage = 'Server error: ${response.statusCode}';
        notifyListeners();
        _showErrorSnackBar(context, _errorMessage!);
      }
    } catch (e, s) {
      Navigator.of(context).pop();
      _errorMessage = 'An unexpected error occurred';
      notifyListeners();
      print('Error: $e');
      print('Stack trace: $s');
      _showErrorSnackBar(context, _errorMessage!);
    }
  }

  void _handleFailedAttempt(
      SharedPreferences prefs, int maxAttempts, Duration lockoutDuration) {
    _failedAttempts++;
    prefs.setInt('failedAttempts', _failedAttempts);

    if (_failedAttempts >= maxAttempts) {
      _lockoutTime = DateTime.now().add(lockoutDuration);
      prefs.setString('lockoutTime', _lockoutTime!.toIso8601String());
      _errorMessage = 'Too many failed attempts. Please try again later.';
      notifyListeners();
    } else {
      _errorMessage = 'Invalid credentials. Try again.';
      notifyListeners();
    }
  }

  void _showLockoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        int remainingSeconds =
            _lockoutTime!.difference(DateTime.now()).inSeconds;
        return StatefulBuilder(
          builder: (context, setState) {
            _lockoutTimer?.cancel();
            _lockoutTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
              remainingSeconds =
                  _lockoutTime!.difference(DateTime.now()).inSeconds;
              if (remainingSeconds <= 0) {
                timer.cancel();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('You can now try again.')),
                );
              }
              setState(() {});
            });
            return AlertDialog(
              title: const Text('Too Many Attempts'),
              backgroundColor: AppColorConstant.errorColor,
              content: Text(
                remainingSeconds > 0
                    ? 'Too many failed attempts. Try again in $remainingSeconds seconds.'
                    : 'You can now try again.',
                selectionColor: AppColorConstant.white,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const BodyText(text: 'OK', color: Colors.black),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void setLoggedIn(bool loggedIn) {
    _isLoggedIn = loggedIn;
    notifyListeners();
  }

  Future<void> checkLoginStatus(BuildContext context) async {
    final SharedPreferencesService sharedPrefs = SharedPreferencesService();
    bool isLogged = await sharedPrefs.getBoolPref('logged') ?? false;

    if (isLogged) {
      context.read<CheckLoginProvider>().setLoggedIn(true);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const AdminPage(selectedIndex: 0)),
      );
    }
  }

  Future<void> fetchUserInfo(String id) async {
    try {
      _isLoading = true;
      notifyListeners();

      final url = '${ApiConstant.localUrl}${ApiConstant.getAdminInfo(id)}';
      print('Request URL: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('Response: $response');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var apiResponse = jsonDecode(response.body);
        if (apiResponse['status'] == 'success' && apiResponse['data'] != null) {
          var userData = apiResponse['data']['user'] as List;
          _user = userData.map((userJson) => User.fromJson(userJson)).toList();

          for (int i = 0; i < _user.length; i++) {
            print('User $i: ${_user[i].id}');
          }

          if (_user.isNotEmpty) {
            _id = _user[0].id!;
          }
        }
      } else {
        print('Failed to load user info. Status code: ${response.statusCode}');
      }

      _isLoading = false;
      notifyListeners();
    } catch (e, s) {
      print('Error: $e');
      print('Stack trace: $s');
      _isLoading = false;
      handleSubmissionError(e);
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    _isLoading = false;
    _user.clear();
    _failedAttempts = 0;
    _lockoutTime = null;
    notifyListeners();
  }

  /*---------------------------------Update Service---------------------------------*/
  Future<void> updateuserInfo({
    required String id,
    required String fname,
    required String username,
    required String email,
    required String phoneNumber,
    required String location,
    required String bio,
    Uint8List? imageBytes,
    String? imgSource,
  }) async {
    try {
      final SharedPreferencesService sharedPrefs = SharedPreferencesService();
      String? token = await sharedPrefs.getTokenPref('userToken');
      if (token == null) {
        print('No token found');
        return;
      }

      final uri = Uri.parse('${ApiConstant.localUrl}/api/admin/$id');

      String mimeType = '';
      String extension =
          imgSource != null ? imgSource.split('.').last.toLowerCase() : '';

      if (imgSource != null) {
        switch (extension) {
          case 'jpeg':
          case 'jpg':
            mimeType = 'image/jpeg';
            break;
          case 'png':
            mimeType = 'image/png';
            break;
          case 'heic':
            mimeType = 'image/heic';
            break;
          case 'gif':
            mimeType = 'image/gif';
            break;
          case 'webp':
            mimeType = 'image/webp';
            break;
          case 'avif':
            mimeType = 'image/avif';
            break;
          default:
            throw Exception('Unsupported image format');
        }
      }

      var request = http.MultipartRequest('PATCH', uri)
        ..fields['fname'] = fname
        ..fields['username'] = username
        ..fields['email'] = email
        ..fields['phoneNumber'] = phoneNumber
        ..fields['location'] = location
        ..fields['bio'] = bio
        ..headers['Authorization'] = 'Bearer $token';

      if (imageBytes != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'imageUrl',
          imageBytes,
          filename: imgSource,
          contentType: MediaType.parse(mimeType),
        ));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse.fromJson(json.decode(response.body));
        if (apiResponse.status == true) {
          await fetchUserInfo(id);
        } else {
          print('Failed to update service: ${apiResponse.message}');
        }
      } else {
        print('Failed to update service. Status code: ${response.statusCode}');
      }
    } catch (e, s) {
      print('Error: $e');
      print('Stack trace: $s');
      _isLoading = false;
      handleSubmissionError(e);
      notifyListeners();
    }
  }

  Future<void> updatePassword(
      String id, String currentPassword, String newPassword) async {
    final SharedPreferencesService sharedPrefs = SharedPreferencesService();
    String? token = await sharedPrefs.getTokenPref('userToken');
    print('Retrieved token: $token');

    if (token == null) {
      print('No token found');
      _isLoading = false;
      notifyListeners();
      return;
    }

    final response = await http.patch(
      Uri.parse('${ApiConstant.localUrl}/api/admin/update-password/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'password': currentPassword,
        'newPassword': newPassword,
        'newPasswordConfirm': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Response body: $data');
    } else {
      throw Exception(
          'Failed to update password: ${jsonDecode(response.body)['message']}');
    }
  }

  void handleSubmissionError(error) {
    print(error);
  }
}
