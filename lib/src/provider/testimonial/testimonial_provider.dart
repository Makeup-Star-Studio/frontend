import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      _isLoading = true;
      notifyListeners();

      final response = await _apiTestimonial.get(ApiConstant.getAllTestimonials);
      print("Response: $response");

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

  // Future<String> uploadImage(File imageFile) async {
  //   final uri = Uri.parse('http://localhost:3001/testimonial/uploadReviewPhoto');
  //   final request = http.MultipartRequest('POST', uri)
  //     ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));
    
  //   final response = await request.send();
    
  //   if (response.statusCode == 200) {
  //     final responseBody = await response.stream.bytesToString();
  //     final jsonResponse = jsonDecode(responseBody);
  //     return jsonResponse['imageUrl']; // Assuming the response contains the image URL
  //   } else {
  //     throw Exception('Failed to upload image');
  //   }
  // }

Future<void> postTestimonial(Testimonial testimonial) async {
  try {
    final testimonialJson = testimonial.toJson(); 
    final response = await _apiTestimonial.post(
      ApiConstant.postTestimonials, 
      testimonialJson,
    );
    print("Post Response: $response");


    var apiResponse = ApiResponse.fromJson(response);
    print("API Response: ${apiResponse.toJson()}");

    if (apiResponse.status == true) {

      await fetchTestimonial();
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
