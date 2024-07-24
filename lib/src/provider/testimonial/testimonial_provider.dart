import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:makeupstarstudio/src/api/api_services.dart';
import 'package:makeupstarstudio/src/api/response_model.dart';
import 'package:makeupstarstudio/src/model/testimonial_model.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';

class TestimonialProvider extends ChangeNotifier {
  List<Testimonial> _testimonials = [];

  List<Testimonial> get testimonials => _testimonials;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final StarStudioApiService _apiTestimonial = StarStudioApiService();

  Future<void> fetchTestimonial() async {
    try {
      final response =
          await _apiTestimonial.get(ApiConstant.getAllTestimonials);
      print("Response: $response");

      // Print the received data response in the console
      var apiResponse = ApiResponse.fromJson(response);
      print("API Response: ${apiResponse.toJson()}");

      if (apiResponse.status == true && apiResponse.data != null) {
        var testimonialsData = apiResponse.data['testimonials'] as List;
        _testimonials = testimonialsData
            .map((testimonialJson) => Testimonial.fromJson(testimonialJson))
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
    }
  }

  void handleSubmissionError(error) {
    print(error);
  }
}
