import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:makeupstarstudio/src/api/api_services.dart';
import 'package:makeupstarstudio/src/api/response_model.dart';
import 'package:makeupstarstudio/src/model/testimonial_model.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';

class TestimonialProvider extends ChangeNotifier {
  List<Testimonial> _testimonials = [];
  List<Testimonial> get testimonials => _testimonials;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final StarStudioApiService _apiTestimonial = StarStudioApiService();

/*---------------------------------Fetch Testimonial---------------------------------*/
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
        _testimonials =
            _testimonials.reversed.toList(); // Reverse to show latest first
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
  
// Future<void> uploadAndPostTestimonial({
//   required String fname,
//   required String lname,
//   required String review,
//   required Uint8List imageBytes,
//   required String imageName,
// }) async {
//   _isLoading = true;
//   notifyListeners();

//   try {
//     // Retrieve token
//     final SharedPreferencesService sharedPrefs = SharedPreferencesService();
//     String? token = await sharedPrefs.getTokenPref('userToken');

//     if (token == null) {
//       print('No token found');
//       _isLoading = false;
//       notifyListeners();
//       return;
//     }

//     // Upload the image and get the image URL
//     final imageUploadResponse = await uploadReviewImage(
//       imageBytes: imageBytes,
//       imageName: imageName,
//     );

//     if (imageUploadResponse == null) {
//       print('Image upload failed. Cannot post testimonial.');
//       _isLoading = false;
//       notifyListeners();
//       return;
//     }

//     // Post testimonial with the image URL
//     final response = await http.post(
//       Uri.parse('${ApiConstant.localUrl}/api/testimonial/'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//       body: json.encode({
//         'fname': fname,
//         'lname': lname,
//         'review': review,
//         'reviewImage': imageUploadResponse, // URL of the uploaded image
//       }),
//     );

//    if (response.statusCode == 201) {
//   final responseData = json.decode(response.body);
//   Testimonial newTestimonial = Testimonial.fromJson(responseData['data']);
//   _testimonials.insert(0, newTestimonial);
//   notifyListeners();
// } else {
//   final responseBody = json.decode(response.body);
//   final errorMessage = responseBody['message'] ?? 'An unknown error occurred';
//   print('Server Error: $responseBody'); // Print the full response body
//   throw Exception('Failed to post testimonial: $errorMessage');
// }

//   } catch (e, s) {
//     print('Error: $e');
//     print('Stack trace: $s');
//     _isLoading = false;
//     handleSubmissionError(e);
//     notifyListeners();
//   } finally {
//     _isLoading = false;
//     notifyListeners();
//   }
// }


Future<String?> uploadReviewImage({
  required Uint8List imageBytes,
  required String imageName,
}) async {
  try {
    final SharedPreferencesService sharedPrefs = SharedPreferencesService();
    String? token = await sharedPrefs.getTokenPref('userToken');
    print('Retrieved token: $token');

    if (token == null) {
      print('No token found');
      return null;
    }

    final uri = Uri.parse('${ApiConstant.localUrl}/api/testimonial/upload');
    print('Posting to URL: $uri');

    var request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile.fromBytes(
        'reviewImage',
        imageBytes,
        filename: imageName,
        contentType: MediaType.parse('image/jpeg'), // Adjust the content type
      ));

    request.headers['Authorization'] = 'Bearer $token';

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print("Post Response Status Code: ${response.statusCode}");
    print("Post Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print("API Response: $jsonResponse");

      // Check if the response contains the expected URL field
      if (jsonResponse['url'] != null) {
        return jsonResponse['url'];
      } else if (jsonResponse['data'] != null && jsonResponse['data']['imageUrl'] != null) {
        return jsonResponse['data']['imageUrl'];
      } else {
        print('No valid image URL found in the response.');
      }
    } else {
      print('Failed to post testimonial. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e, s) {
    print('Error: $e');
    print('Stack trace: $s');
  }

  return null;
}


/*---------------------------------Post Testimonial---------------------------------*/
  Future<void> postTestimonial(
      {required String fname, required String lname,required String review, required String reviewImage}) async{
    _isLoading = true;
    notifyListeners();
    try {
      final SharedPreferencesService sharedPrefs = SharedPreferencesService();
      String? token = await sharedPrefs.getTokenPref('userToken');
      print('Retrieved token: $token');

      if (token == null) {
        print('No token found');
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await http.post(
        Uri.parse('${ApiConstant.localUrl}/api/testimonial/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'fname': fname,
          'lname': lname,
          'review': review,
          'reviewImage': reviewImage,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        // Create a new Testimonial object
        Testimonial newTestimonial = Testimonial.fromJson(responseData['data']['testimonial']);
        // Insert the new testimonial at the beginning of the list
        _testimonials.insert(0, newTestimonial);
        notifyListeners();
      } else {
        final responseBody = json.decode(response.body);
        // Extract the error message if available
        final errorMessage =
            responseBody['message'] ?? 'An unknown error occurred';
        throw Exception('Failed to post testimonial: $errorMessage');
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

/*---------------------------------Update Testimonial---------------------------------*/
// update the posted testimonial
  Future<void> updateTestimonial(String id, Testimonial testimonial) async {
    _isLoading = true;
    notifyListeners();
    try {
      final SharedPreferencesService sharedPrefs = SharedPreferencesService();
      String? token = await sharedPrefs.getTokenPref('userToken');
      print('Retrieved token: $token');

      if (token == null) {
        print('No token found');
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await http.put(
        Uri.parse('${ApiConstant.localUrl}/api/testimonial/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'fname': testimonial.fname,
          'lname': testimonial.lname,
          'review': testimonial.review,
          // Exclude image as per requirements
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // Update local state
        _testimonials = _testimonials.map((item) {
          if (item.id == id) {
            return Testimonial.fromJson(responseData['data']['testimonial']);
          }
          return item;
        }).toList();
        await fetchTestimonial();

        print('Testimonial updated: ${responseData['data']['testimonial']}');
      } else {
        final responseBody = json.decode(response.body);
        // Extract the error message if available
        final errorMessage =
            responseBody['message'] ?? 'An unknown error occurred';
        throw Exception('Failed to update testimonial: $errorMessage');
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

  /*---------------------------------Delete Testimonial---------------------------------*/

  Future<void> deleteTestimonial(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      final SharedPreferencesService sharedPrefs = SharedPreferencesService();
      String? token = await sharedPrefs.getTokenPref('userToken');
      print('Retrieved token: $token');

      if (token == null) {
        print('No token found');
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await http.delete(
        Uri.parse('${ApiConstant.localUrl}/api/testimonial/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 204) {
        _testimonials.removeWhere((testimonial) => testimonial.id == id);

        await fetchTestimonial();
      } else {
        final responseBody = json.decode(response.body);
        throw Exception(
            'Failed to delete testimonial: ${responseBody['message']}');
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
