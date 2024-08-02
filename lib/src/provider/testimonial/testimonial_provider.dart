import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
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

      final response =
          await _apiTestimonial.get(ApiConstant.getAllTestimonials);
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

Future<void> postTestimonial({
  required String fname,
  required String lname,
  required String review,
  required Uint8List imageBytes,
  required String imageName,
}) async {
  try {
    final uri = Uri.parse(ApiConstant.postTestimonials);

    // Determine the correct content type for the image
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

    var request = http.MultipartRequest('POST', uri)
      ..fields['fname'] = fname
      ..fields['lname'] = lname
      ..fields['review'] = review
      ..files.add(http.MultipartFile.fromBytes(
        'reviewImage',
        imageBytes,
        filename: imageName,
        contentType: MediaType.parse(mimeType),
      ));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print("Post Response: ${response.body}");

    if (response.statusCode == 201) {
      var apiResponse = ApiResponse.fromJson(json.decode(response.body));
      print("API Response: ${apiResponse.toJson()}");

      if (apiResponse.status == true) {
        await fetchTestimonial();
      }
    } else {
      print('Failed to post testimonial. Status code: ${response.statusCode}');
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
