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
  _isLoading = true;
  notifyListeners(); // Notify listeners before starting the fetch

  try {
    final response = await http.get(
      Uri.parse('${ApiConstant.localUrl}/api/admin/'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    // print("URL----> ${ApiConstant.localUrl}/api/admin/");
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Debug print for JSON structure
      var responseData = json.decode(response.body);
      // print('Decoded response data: $responseData');

      // Check if the response data is in expected format
        _user = UserModel.fromJson(responseData);
        _isLoading = false;
        notifyListeners(); // Notify listeners after data is loaded
     
    } else {
      print('Failed to load user details, Status code: ${response.statusCode}');
      throw Exception('Failed to load user details');
    }
  } catch (e) {
    print('Error occurred while fetching user info: $e');
    _isLoading = false;
    notifyListeners(); // Notify listeners in case of error
  }
}


  /*---------------------------------Upload Admin Image---------------------------------*/
  Future<String?> uploadAdminImage(
    Uint8List? imageBytes,
    String? imageName,
  ) async {
    try {
      final SharedPreferencesService sharedPrefs = SharedPreferencesService();
      String? token = await sharedPrefs.getTokenPref('userToken');
      if (token == null) {
        // print('No token found');
        return null;
      }

      final uri = Uri.parse('${ApiConstant.localUrl}/api/admin/upload');
      var request = http.MultipartRequest('POST', uri)
        ..files.add(http.MultipartFile.fromBytes(
          'imageUrl',
          imageBytes!,
          filename: imageName,
          contentType: MediaType('image', 'jpeg'), // Adjust if needed
        ))
        ..headers['Authorization'] = 'Bearer $token';

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['url'] != null) {
          return jsonResponse['url'];
        } else if (jsonResponse['data'] != null &&
            jsonResponse['data']['imageUrl'] != null) {
          return jsonResponse['data']['imageUrl'];
        } else {
          print('No valid image URL found in the response.');
        }
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        // print('Response body: ${response.body}');
      }
    } catch (e, s) {
      print('Error: $e');
      print('Stack trace: $s');
    }

    return null;
  }

  /*---------------------------------Update User Information---------------------------------*/
  Future<void> updateUserInfo({
    required String fname,
    required String username,
    required String email,
    required String phoneNumber,
    String? bio,
    String? location,
    String? imageUrl,
    String? id,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');
      String? token = prefs.getString('userToken');

      // print('Retrieved userId: $userId');
      // print('Retrieved token: $token');

      if (userId == null || token == null) {
        // print('User ID or token is missing');
        _isLoading = false;
        notifyListeners();
        return;
      }
      final response = await http.patch(
        Uri.parse('${ApiConstant.localUrl}/api/admin/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'fname': fname,
          'username': username,
          'email': email,
          'phoneNumber': phoneNumber,
          'bio': bio ?? '',
          'location': location ?? '',
          'imageUrl': imageUrl ?? '',
        }),
      );

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
