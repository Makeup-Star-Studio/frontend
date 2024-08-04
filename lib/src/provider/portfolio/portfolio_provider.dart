import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:makeupstarstudio/src/api/api_services.dart';
import 'package:makeupstarstudio/src/api/response_model.dart';
import 'package:makeupstarstudio/src/model/portfolio_model.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';

class PortfolioProvider extends ChangeNotifier {
  List<Portfolio> _portfolio = [];

  List<Portfolio> get portfolio => _portfolio;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final StarStudioApiService _apiPortfolio = StarStudioApiService();

  Future<void> fetchAllPortfolios() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _apiPortfolio.get(ApiConstant.getAllPortfolio);
      print("Response: $response");

      var apiResponse = ApiResponse.fromJson(response);
      if (apiResponse.status == true && apiResponse.data != null) {
        // Handling nested structure
        var portfolioData = apiResponse.data['portfolio'] as List;
        _portfolio = portfolioData
            .map((portfolioJson) => Portfolio.fromJson(portfolioJson))
            .toList();
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

  /*---------------------------------Post service---------------------------------*/
  Future<void> postPortfolio({
    required String category,
    required List<Uint8List> imageBytesList, // Changed to a list of Uint8List
    required List<String> imageNames, // List of image file names
  }) async {
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

      final uri = Uri.parse('${ApiConstant.localUrl}/portfolio/');
      print('Posting to URL: $uri');

      var request = http.MultipartRequest('POST', uri)
        ..fields['category'] = category;

      // Add multiple images to the request
      for (int i = 0; i < imageBytesList.length; i++) {
        final imageBytes = imageBytesList[i];
        final imageName = imageNames[i];
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
          default:
            throw Exception('Unsupported image format');
        }

        request.files.add(http.MultipartFile.fromBytes(
          'portfolioImage', // Name of the field
          imageBytes,
          filename: imageName,
          contentType: MediaType.parse(mimeType),
        ));
      }

      request.headers['Authorization'] = 'Bearer $token';

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("Post Response Status Code: ${response.statusCode}");
      print("Post Response Body: ${response.body}");

      if (response.statusCode == 201) {
        var apiResponse = ApiResponse.fromJson(json.decode(response.body));
        print("API Response: ${apiResponse.toJson()}");

        if (apiResponse.status == false) {
          print('Failed to post portfolio: ${apiResponse.message}');
        }
      } else {
        print('Failed to post portfolio. Status code: ${response.statusCode}');
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
