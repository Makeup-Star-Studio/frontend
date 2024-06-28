import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:makeupstarstudio/src/api/api_service.dart';
import 'package:makeupstarstudio/src/api/api_services.dart';
import 'package:makeupstarstudio/src/model/services_model.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';

class ServicesProvider extends ChangeNotifier {
  List<Service> _services = [];
  List<Service> _filteredServices = [];

  List<Service> get services => _services;
  List<Service> get filteredServices => _filteredServices;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
    final StarStudioApiService _apiService = StarStudioApiService();
  final HttpRepo  _httpRepo = HttpServices();

  Future<void> fetchServices() async {
    try {
      _isLoading = true;
      notifyListeners();

      // final response = await http.get(Uri.parse(ApiConstant.getServices));
      final response = await _httpRepo.get(ApiConstant.getServices);
      print("Response: ${response.data}"); 

   
        var decodedResponse = ServicesModel.fromRawJson(response.data);
        _services = decodedResponse.data.services;
        _filteredServices = _services;
     

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

  // void filterServices(String query) {
  //   final lowerCaseQuery = query.toLowerCase();
  //   _filteredServices = _services.where((service) {
  //     return service.title.toLowerCase().contains(lowerCaseQuery) ||
  //         service.category.toLowerCase().contains(lowerCaseQuery);
  //   }).toList();
  //   notifyListeners();
  // }

  void handleSubmissionError(error) {
    print(error);
  }
}
