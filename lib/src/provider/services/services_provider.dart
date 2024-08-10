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

/*---------------------------------Upload Service Image---------------------------------*/
  Future<String?> uploadServiceImage(
    Uint8List? imageBytes,
    String? imageName,
  ) async {
    try {
      final SharedPreferencesService sharedPrefs = SharedPreferencesService();
      String? token = await sharedPrefs.getTokenPref('userToken');
      if (token == null) {
        print('No token found');
        return null;
      }

      final uri = Uri.parse('${ApiConstant.localUrl}/api/services/upload');
      var request = http.MultipartRequest('POST', uri)
        ..files.add(http.MultipartFile.fromBytes(
          'image',
          imageBytes!,
          filename: imageName,
          contentType: MediaType('image', 'jpeg'), // Adjust if needed
        ))
        ..headers['Authorization'] = 'Bearer $token';

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['url'] != null) {
          return jsonResponse['url'];
        } else if (jsonResponse['data'] != null &&
            jsonResponse['data']['imageUrl'] != null) {
          return jsonResponse['data']['imageUrl'];
        } else {
          print('No valid image URL found in the response.');
        }
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e, s) {
      print('Error: $e');
      print('Stack trace: $s');
    }

    return null;
  }

  /*---------------------------------Post service---------------------------------*/
  Future<void> postService(
      {required String title,
      required double price,
      required String category,
      String? image}) async {
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

      // Check if there's already an image for the category
      Service? existingService = _services.firstWhere(
          (service) => service.category == category,
          orElse: () => Service(title: '', price: 0, category: '', image: ''));
      String? existingImageUrl =
          existingService.image!.isNotEmpty ? existingService.image : null;

      final response = await http.post(
        Uri.parse('${ApiConstant.localUrl}/api/services/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'title': title,
          'price': price,
          'category': category,
          'image': image ?? existingImageUrl,
        }),
      );
      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        // Create a new Testimonial object
        Service newService = Service.fromJson(responseData['data']['services']);
        // Insert the new testimonial at the beginning of the list

        _services.insert(0, newService);
        notifyListeners();
      } else {
        final responseBody = json.decode(response.body);
        // Extract the error message if available
        final errorMessage =
            responseBody['message'] ?? 'An unknown error occurred';
        throw Exception('Failed to post service: $errorMessage');
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

/*---------------------------------Update Service---------------------------------*/
  Future<void> updateService(
    String id,
    Service services,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      final SharedPreferencesService sharedPrefs = SharedPreferencesService();
      String? token = await sharedPrefs.getTokenPref('userToken');
      if (token == null) {
        print('No token found');
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await http.put(
        Uri.parse('${ApiConstant.localUrl}/api/services/edit/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'title': services.title,
          'price': services.price,
          'category': services.category,
          'image': services.image,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // Update local state
        _services = _services.map((item) {
          if (item.id == id) {
            return Service.fromJson(responseData['data']['services']);
          }
          return item;
        }).toList();
        await fetchAllServices();

        print('Services updated: ${responseData['data']['services']}');
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
