import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:makeupstarstudio/src/api/api_services.dart';
import 'package:makeupstarstudio/src/model/portfolio_model.dart';
import 'package:makeupstarstudio/src/model/response_model.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';

class WhiteBridalProvider extends ChangeNotifier {
  List<Portfolio> _portfolio = [];
  List<Portfolio> _filteredPortfolio = [];

  List<Portfolio> get portfolio => _portfolio;
  List<Portfolio> get filteredPortfolio => _filteredPortfolio;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final StarStudioApiService _apiService = StarStudioApiService();

  Future<void> fetchWhiteBridalGallery() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _apiService.get(ApiConstant.getWhiteBridalGallery);
      // print("Response: $response");

      var apiResponse = ApiResponse.fromJson(response);

      if (apiResponse.status == true && apiResponse.data != null) {
        // Handling nested structure
        var portfolioData = apiResponse.data['portfolio'] as List;
        _portfolio = portfolioData
            .map((portfolioJson) => Portfolio.fromJson(portfolioJson))
            .toList();
        _filteredPortfolio = _portfolio;
        // reverse to show latest first
        _filteredPortfolio = _portfolio.reversed.toList();
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

  Future<void> deleteWhiteBrideGallery() async {
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
            '${ApiConstant.localUrl}${ApiConstant.deleteWhiteBridePortfolioByCat}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 204) {
        // _portfolio.clear();
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
