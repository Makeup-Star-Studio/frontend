import 'dart:convert'; // To parse JSON

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:makeupstarstudio/src/model/portfolio_model.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';

class BridalPortfolioProvider extends ChangeNotifier {
  final List<Portfolio> _portfolio = [];
  List<Portfolio> _filteredPortfolio = [];

  List<Portfolio> get portfolio => _portfolio;
  List<Portfolio> get filteredPortfolio => _filteredPortfolio;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> fetchBridalPortfolios() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await http.get(
        Uri.parse('${ApiConstant.localUrl}${ApiConstant.getBridalPortfolio}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      // print url
      print('${ApiConstant.localUrl}${ApiConstant.getBridalPortfolio}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final portfolioModel = PortfolioModel.fromJson(data);

        _filteredPortfolio = portfolioModel.data.portfolio;
      } else {
        // Handle errors, such as displaying a message to the user
        throw Exception('Failed to load portfolio');
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
    // Handle any submission errors, perhaps log or display a user-friendly message
    print('Error occurred: $error');
  }
}
