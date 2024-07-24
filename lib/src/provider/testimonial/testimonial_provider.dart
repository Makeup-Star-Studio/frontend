import 'package:flutter/material.dart';
import 'package:makeupstarstudio/src/api/api_services.dart';
import 'package:makeupstarstudio/src/api/response_model.dart';
import 'package:makeupstarstudio/src/model/testimonial_model.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';

class TestimonialProvider extends ChangeNotifier {
  List<Testimonial> _testimonials = [];
  // List<Testimonial> _filteredTestimonials = [];

  List<Testimonial> get testimonials => _testimonials;
  // List<Testimonial> get filteredTestimonials => _filteredTestimonials;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final StarStudioApiService _apiTestimonial = StarStudioApiService();

  Future<void> fetchTestimonial() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response =
          await _apiTestimonial.get(ApiConstant.getAllTestimonials);
      print("Response: $response");

      var apiResponse = ApiResponse.fromJson(response);
      if (apiResponse.status == true && apiResponse.data != null) {
        // Handling nested structure
        var testimonialsData = apiResponse.data['testimonials'] as List;
        _testimonials = testimonialsData
            .map((testimonialJson) => Testimonial.fromJson(testimonialJson))
            .toList();
        // _filteredTestimonials = _testimonials;
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
