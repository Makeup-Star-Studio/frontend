import 'package:flutter/material.dart';
import 'package:makeupstarstudio/src/api/response_model.dart';
import 'package:makeupstarstudio/src/api/api_services.dart';
import 'package:makeupstarstudio/src/model/services_model.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';

class HennaServicesProvider extends ChangeNotifier {
  List<Service> _services = [];
  List<Service> _filteredServices = [];

  List<Service> get services => _services;
  List<Service> get filteredServices => _filteredServices;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final StarStudioApiService _apiService = StarStudioApiService();

  Future<void> fetchHennaServices() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _apiService.get(ApiConstant.getHennaServices);
      print("Response: $response");

      var apiResponse = ApiResponse.fromJson(response);
      if (apiResponse.status == true && apiResponse.data != null) {
        // Handling nested structure
        var servicesData = apiResponse.data['services'] as List;
        _services = servicesData
            .map((serviceJson) => Service.fromJson(serviceJson))
            .toList();
        _filteredServices = _services;
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
