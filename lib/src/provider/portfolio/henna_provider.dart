import 'package:flutter/material.dart';
import 'package:makeupstarstudio/src/api/api_services.dart';
import 'package:makeupstarstudio/src/api/response_model.dart';
import 'package:makeupstarstudio/src/model/portfolio_model.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';

class HennaGalleryProvider extends ChangeNotifier {
  List<Portfolio> _portfolio = [];
  List<Portfolio> _filteredPortfolio = [];

  List<Portfolio> get portfolio => _portfolio;
  List<Portfolio> get filteredPortfolio => _filteredPortfolio;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final StarStudioApiService _apiPortfolio = StarStudioApiService();

  Future<void> fetchHennaGallery() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _apiPortfolio.get(ApiConstant.getHennaGallery);
      print("Response: $response");

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

  void handleSubmissionError(error) {
    print(error);
  }
}
