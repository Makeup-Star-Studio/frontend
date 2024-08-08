import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:makeupstarstudio/src/api/api_services.dart';
import 'package:makeupstarstudio/src/model/user_model.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  final SharedPreferencesService _sharedPrefs = SharedPreferencesService();

  UserModel? _user;
  UserModel? get user => _user;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final StarStudioApiService _apiUser = StarStudioApiService();

  /*---------------------------------Fetch User Information---------------------------------*/
  Future<void> fetchUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? token = prefs.getString('userToken');

    print('Retrieved userId: $userId'); 
    print('Retrieved token: $token'); 

    if (userId != null && token != null) {
      final response = await http.get(
        Uri.parse('${ApiConstant.localUrl}/api/admin/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      
      print("URL----> ${ApiConstant.localUrl}/api/admin/$userId");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        _user = UserModel.fromJson(responseData);
        notifyListeners();
      } else {
        throw Exception('Failed to load user details');
      }
    } else {
      print('User ID or token is missing');
    }
      _isLoading = false;
  notifyListeners();

  }

  /*---------------------------------Update User Information---------------------------------*/
  Future<void> updateUserInfo({
    required String fname,
    required String username,
    required String email,
    required String phoneNumber,
    required String bio,
    required String location,
    required Uint8List? imageBytes,
    required String? imageName,
    required String id,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');
      String? token = prefs.getString('userToken');

      print('Retrieved userId: $userId'); 
      print('Retrieved token: $token'); 

      if (userId == null || token == null) {
        print('User ID or token is missing');
        _isLoading = false;
        notifyListeners();
        return;
      }

      final uri = Uri.parse('${ApiConstant.localUrl}/api/admin/$userId');
      var request = http.MultipartRequest('PATCH', uri)
        ..fields['fname'] = fname
        ..fields['username'] = username
        ..fields['email'] = email
        ..fields['phoneNumber'] = phoneNumber
        ..fields['bio'] = bio
        ..fields['location'] = location;

      if (imageBytes != null && imageName != null) {
        String mimeType;
        String extension = imageName.split('.').last.toLowerCase();

        switch (extension) {
          case 'jpeg':
          case 'jpg':
            mimeType = 'image/jpeg';
            break;
          case 'png':
            mimeType = 'image/png';
            break;
          default:
            throw Exception('Unsupported image format');
        }
        request.files.add(http.MultipartFile.fromBytes(
          'imageUrl',
          imageBytes,
          filename: imageName,
          contentType: MediaType.parse(mimeType),
        ));
      }

      request.headers['Authorization'] = 'Bearer $token';

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        await fetchUserInfo();
        notifyListeners();
      } else {
        print('Failed to update user. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      _isLoading = false;
      notifyListeners();
    } catch (e, s) {
      print('Error: $e');
      print('Stack trace: $s');
      _isLoading = false;
      handleSubmissionError(e);
      notifyListeners();
    }
  }

  void handleSubmissionError(error) {
    print(error);
  }
}
