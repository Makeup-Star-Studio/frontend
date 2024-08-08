import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:makeupstarstudio/src/api/api_services.dart';
import 'package:makeupstarstudio/src/api/response_model.dart';
import 'package:makeupstarstudio/src/model/user_model.dart'; // Import your UserModel here
import 'package:makeupstarstudio/src/services/shared_pref.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final StarStudioApiService _apiUser = StarStudioApiService();

  /*---------------------------------Fetch User Information---------------------------------*/
Future<void> fetchUserInfo(String id) async {
  try {
    _isLoading = true;
    notifyListeners();

    final response = await _apiUser.get(ApiConstant.getAdminInfo(id));
    print("Response: $response");

    // Assuming ApiResponse has a data field which is a Map
    var apiResponse = ApiResponse.fromJson(response);
    print("API Response: ${apiResponse.toJson()}");

    if (apiResponse.status == true && apiResponse.data != null && apiResponse.data.containsKey('user')) {
      _user = UserModel.fromJson({
        'status': apiResponse.status.toString(),
        'data': apiResponse.data
      });
    } else {
      _user = null;
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


  /*---------------------------------Update User Information---------------------------------*/
Future<void> updateUserInfo({
  required String id,
  required String fname,
  required String username,
  required String email,
  required String phoneNumber,
  required String bio,
  required String location,
  required Uint8List? imageBytes,
  required String? imageName,
}) async {
  _isLoading = true;
  notifyListeners();
  try {
    final SharedPreferencesService sharedPrefs = SharedPreferencesService();
    String? token = await sharedPrefs.getTokenPref('userToken');
    print('Retrieved token: $token');

    if (token == null) {
      print('No token found');
      _isLoading = false;
      notifyListeners();
      return;
    }

    final uri = Uri.parse('${ApiConstant.localUrl}/api/admin/$id');
    print('Posting to URL: $uri');
  
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
    print("Update Response Status Code: ${response.statusCode}");
    print("Update Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var apiResponse = ApiResponse.fromJson(json.decode(response.body));
      print("API Response: ${apiResponse.toJson()}");

      if (apiResponse.status == true) {
        await fetchUserInfo(id); 
        notifyListeners();
      }
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
