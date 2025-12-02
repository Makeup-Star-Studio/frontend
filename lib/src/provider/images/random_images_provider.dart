import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:makeupstarstudio/src/api/api_services.dart';
import 'package:makeupstarstudio/src/model/images_model.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';

class RandomImageProvider extends ChangeNotifier {
  List<ImageModel> _images = [];

  List<ImageModel> get images => _images;

  final List<RandomImagesModel> _randomImages = [];
  List<RandomImagesModel> get randomImages => _randomImages;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final StarStudioApiService _apiService = StarStudioApiService();

  Future<void> fetchAllImages() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await http.get(
        Uri.parse('${ApiConstant.localUrl}${ApiConstant.getRandomImages}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // print("Response status: ${response.statusCode}");
      // print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        // print("Response Data: $responseData");

        if (responseData['urls'] != null) {
          var imageUrls = responseData['urls'] as List;
          _images = imageUrls
              .map((url) => ImageModel(
                    id: '', // As id is not provided, you can assign a placeholder value
                    filename: '', // Filename is also not provided
                    url: url,
                  ))
              .toList();
        }
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

  // Upload image
  Future<List<String>?> uploadImage(
    List<Uint8List> imageBytesList,
    List<String> imageNames,
  ) async {
    final List<String> uploadedImageUrls = [];

    final SharedPreferencesService sharedPrefs = SharedPreferencesService();
    String? token = await sharedPrefs.getTokenPref('userToken');

    for (int i = 0; i < imageBytesList.length; i++) {
      final uri = Uri.parse('${ApiConstant.localUrl}/api/images/upload');
      var request = http.MultipartRequest('POST', uri)
        ..files.add(http.MultipartFile.fromBytes(
          'imagesUrl',
          imageBytesList[i],
          filename: imageNames[i],
          contentType:
              MediaType('image', 'jpeg'), // Adjust content type if needed
        ))
        ..headers['Authorization'] = 'Bearer $token';

      // print('Request: $request');
      // print('Request uri: ${request.url}');

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        // Assuming response contains URLs in 'images' field
        List<String>? urls = (jsonResponse['images'] as List<dynamic>?)
            ?.map((url) => url.toString())
            .toList();

        if (urls != null) {
          uploadedImageUrls.addAll(urls);
        } else {
          print('No valid image URLs found in the response.');
        }
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        // print('Response body: ${response.body}');
      }
    }

    return uploadedImageUrls.isNotEmpty ? uploadedImageUrls : null;
  }

// Delete a single image
  Future<void> deleteImage(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      final SharedPreferencesService sharedPrefs = SharedPreferencesService();
      String? token = await sharedPrefs.getTokenPref('userToken');

      final url = '${ApiConstant.localUrl}/api/images/delete/$id';
      // print('Deleting image with URL: $url');

      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // _images.removeWhere((image) => image.id == imageId);
        notifyListeners();
      } else {
        final responseBody = json.decode(response.body);
        final errorMessage =
            responseBody['message'] ?? 'An unknown error occurred';
        throw Exception('Failed to delete image: $errorMessage');
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

  // Delete all images
  Future<void> deleteAllImages() async {
    _isLoading = true;
    notifyListeners();
    try {
      final SharedPreferencesService sharedPrefs = SharedPreferencesService();
      String? token = await sharedPrefs.getTokenPref('userToken');

      final response = await http.delete(
        Uri.parse('${ApiConstant.localUrl}/api/images/'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _images.clear();
        notifyListeners();
      } else {
        final responseBody = json.decode(response.body);
        final errorMessage =
            responseBody['message'] ?? 'An unknown error occurred';
        throw Exception('Failed to delete all images: $errorMessage');
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
    print(error);
  }
}
