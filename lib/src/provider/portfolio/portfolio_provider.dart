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
      // print("Response: $response");

      var apiResponse = ApiResponse.fromJson(response);
      if (apiResponse.status == true && apiResponse.data != null) {
        // Handling nested structure
        var portfolioData = apiResponse.data['portfolios'] as List;
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

  /*---------------------------------Upload Portfolio Image---------------------------------*/
  Future<List<String>?> uploadPortfolioImages(
    String category,
    List<Uint8List> imageBytesList,
    List<String> imageNames,
  ) async {
    final List<String> uploadedImageUrls = [];
    final SharedPreferencesService sharedPrefs = SharedPreferencesService();
    String? token = await sharedPrefs.getTokenPref('userToken');

    if (token == null) {
      // print('No token found');
      return null;
    }

    for (int i = 0; i < imageBytesList.length; i++) {
      final uri = Uri.parse('${ApiConstant.localUrl}/api/portfolio/upload');
      var request = http.MultipartRequest('POST', uri)
        ..fields['category'] = category
        ..files.add(http.MultipartFile.fromBytes(
          'portfolioImage',
          imageBytesList[i],
          filename: imageNames[i],
          contentType:
              MediaType('image', 'jpeg'), // Adjust content type if needed
        ))
        ..headers['Authorization'] = 'Bearer $token';

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        // Extract URLs from the response
        List<String>? urls = (jsonResponse['urls'] as List<dynamic>?)
            ?.map((url) => url.toString())
            .toList();

        if (urls != null) {
          uploadedImageUrls.addAll(urls);
        } else {
          print('No valid image URLs found in the response.');
        }
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        // print('Response body: ${response.body}');
      }
    }

    return uploadedImageUrls.isNotEmpty ? uploadedImageUrls : null;
  }

  /*---------------------------------Post portfolio---------------------------------*/
  Future<void> postPortfolio(
      {required String category, List<String>? portfolioImage}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final SharedPreferencesService sharedPrefs = SharedPreferencesService();
      String? token = await sharedPrefs.getTokenPref('userToken');
      // print('Retrieved token: $token');

      if (token == null) {
        // print('No token found');
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await http.post(
        Uri.parse('${ApiConstant.localUrl}/api/portfolio/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'category': category,
          'portfolioImage': portfolioImage,
        }),
      );
      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        // Create a new Tesportfoliotimonial object
        Portfolio newPortfolio = Portfolio.fromJson(responseData['data']);
        // Insert the new testimonial at the beginning of the list

        _portfolio.insert(0, newPortfolio);
        notifyListeners();
      } else {
        final responseBody = json.decode(response.body);
        // Extract the error message if available
        final errorMessage =
            responseBody['message'] ?? 'An unknown error occurred';
        throw Exception('Failed to post portfolios: $errorMessage');
      }
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

  /*---------------------------------Delete portfolio---------------------------------*/
  Future<void> deleteOnePortfolioImage(
      String portfolioId, String imageId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final SharedPreferencesService sharedPrefs = SharedPreferencesService();
      String? token = await sharedPrefs.getTokenPref('userToken');
      // print('Retrieved token: $token');

      if (token == null) {
        // print('No token found');
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await http.delete(
        Uri.parse(
            '${ApiConstant.localUrl}${ApiConstant.deletePortfolio(portfolioId, imageId)}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 204) {
        // _portfolio.clear();
        // Successfully deleted the image
        // Update the state or UI to reflect the deletion
        // Find the portfolio object
        final portfolioIndex =
            _portfolio.indexWhere((portfolio) => portfolio.id == portfolioId);
        if (portfolioIndex != -1) {
          // Find the image object
          final imageIndex = _portfolio[portfolioIndex]
              .portfolioImage
              .indexWhere((image) => image.id == imageId);
          if (imageIndex != -1) {
            // Remove the image from the portfolio object
            _portfolio[portfolioIndex].portfolioImage.removeAt(imageIndex);
          }
        }

        notifyListeners();
      } else {
        final responseBody = json.decode(response.body);
        final errorMessage =
            responseBody['message'] ?? 'An unknown error occurred';
        throw Exception('Failed to delete all images: $errorMessage');
      }
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

  Future<void> deletePortfolioByCat(String category) async {
    _isLoading = true;
    notifyListeners();
    try {
      final SharedPreferencesService sharedPrefs = SharedPreferencesService();
      String? token = await sharedPrefs.getTokenPref('userToken');
      // print('Retrieved token: $token');

      if (token == null) {
        // print('No token found');
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await http.delete(
        Uri.parse(
            '${ApiConstant.localUrl}${ApiConstant.deletePortfolioByCat(category)}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 204) {
        _portfolio.clear();
        // print('Successfully deleted portfolio by category');
        await fetchAllPortfolios(); // Refresh the data to reflect changes
        notifyListeners();
      } else {
        final responseBody = json.decode(response.body);
        final errorMessage =
            responseBody['message'] ?? 'An unknown error occurred';
        throw Exception('Failed to delete all images: $errorMessage');
      }
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

  void handleSubmissionError(error) {
    print(error);
  }
}
