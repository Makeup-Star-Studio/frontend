import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:makeupstarstudio/src/api/api_services.dart';
import 'package:makeupstarstudio/src/api/response_model.dart';
import 'package:makeupstarstudio/src/model/services_model.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';

class ServicesProvider extends ChangeNotifier {
  List<Service> _services = [];

  List<Service> get services => _services;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final StarStudioApiService _apiService = StarStudioApiService();

  Future<void> fetchAllServices() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _apiService.get(ApiConstant.getAllServices);
      print("Response: $response");

      var apiResponse = ApiResponse.fromJson(response);
      if (apiResponse.status == true && apiResponse.data != null) {
        // Handling nested structure
        var servicesData = apiResponse.data['services'] as List;
        _services = servicesData
            .map((serviceJson) => Service.fromJson(serviceJson))
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
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /*---------------------------------Post service---------------------------------*/
  Future<void> postService({
    required String title,
    required double price,
    required String category,
    Uint8List? imageBytes,
    String? imageUrl,
  }) async {
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

      // Check if there's already an image for the category
      Service? existingService = _services.firstWhere(
          (service) => service.category == category,
          orElse: () => Service(title: '', price: 0, category: '', image: ''));
      String? existingImageUrl =
          existingService.image.isNotEmpty ? existingService.image : null;

      final uri = Uri.parse('${ApiConstant.localUrl}/api/services/');
      print('Posting to URL: $uri');

      var request = http.MultipartRequest('POST', uri)
        ..fields['title'] = title
        ..fields['price'] = price.toString()
        ..fields['category'] = category;
      // If imageBytes and imageUrl are provided and there's no existing image for the category
      if (imageBytes != null && imageUrl != null && existingImageUrl == null) {
        String mimeType;
        String extension = imageUrl.split('.').last.toLowerCase();

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
          case 'webp':
            mimeType = 'image/webp';
            break;
          case 'avif':
            mimeType = 'image/avif';
            break;
          default:
            throw Exception('Unsupported image format');
        }

        request.files.add(http.MultipartFile.fromBytes(
          'image',
          imageBytes,
          filename: imageUrl,
          contentType: MediaType.parse(mimeType),
        ));
      } else if (existingImageUrl != null) {
        // Use the existing image URL if present
        request.fields['image'] = existingImageUrl;
      }

      request.headers['Authorization'] = 'Bearer $token';

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("Post Response Status Code: ${response.statusCode}");
      print("Post Response Body: ${response.body}");

      if (response.statusCode == 201) {
        var apiResponse = ApiResponse.fromJson(json.decode(response.body));
        print("API Response: ${apiResponse.toJson()}");

        if (apiResponse.status == true) {
          // Fetch all services to update the list
          await fetchAllServices();
        } else {
          print('Failed to post service: ${apiResponse.message}');
        }
      } else {
        print('Failed to post service. Status code: ${response.statusCode}');
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

/*---------------------------------Update Service---------------------------------*/
  Future<void> updateService({
    required String id,
    required String title,
    required double price,
    required String category,
    Uint8List? imageBytes,
    String? imageUrl,
  }) async {
    try {
      final SharedPreferencesService sharedPrefs = SharedPreferencesService();
      String? token = await sharedPrefs.getTokenPref('userToken');
      if (token == null) {
        print('No token found');
        return;
      }

      final uri = Uri.parse('${ApiConstant.localUrl}/api/services/edit/$id');

      String mimeType = '';
      String extension =
          imageUrl != null ? imageUrl.split('.').last.toLowerCase() : '';

      if (imageUrl != null) {
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
          case 'webp':
            mimeType = 'image/webp';
            break;
          case 'avif':
            mimeType = 'image/avif';
            break;
          default:
            throw Exception('Unsupported image format');
        }
      }

      var request = http.MultipartRequest('PUT', uri)
        ..fields['title'] = title
        ..fields['price'] = price.toString()
        ..fields['category'] = category
        ..headers['Authorization'] = 'Bearer $token';

      if (imageBytes != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image',
          imageBytes,
          filename: imageUrl,
          contentType: MediaType.parse(mimeType),
        ));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var apiResponse = ApiResponse.fromJson(json.decode(response.body));
        if (apiResponse.status == true) {
          await fetchAllServices();
        } else {
          print('Failed to update service: ${apiResponse.message}');
        }
      } else {
        print('Failed to update service. Status code: ${response.statusCode}');
      }
    } catch (e, s) {
      print('Error: $e');
      print('Stack trace: $s');
      _isLoading = false;
      handleSubmissionError(e);
      notifyListeners();
    }
  }

  /*---------------------------------Delete Seervice---------------------------------*/

  Future<void> deleteService(String id) async {
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
        Uri.parse('${ApiConstant.localUrl}/api/services/remove/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 204) {
        _services.removeWhere((service) => service.id == id);
        await fetchAllServices();
      } else {
        final responseBody = json.decode(response.body);
        throw Exception('Failed to delete service: ${responseBody['message']}');
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
