import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:makeupstarstudio/src/api/api_services.dart';
import 'package:makeupstarstudio/src/api/response_model.dart';
import 'package:makeupstarstudio/src/model/booking_model.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';

class BookingProvider extends ChangeNotifier {
  List<Booking> _booking = [];

  List<Booking> get booking => _booking;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final StarStudioApiService _apiBooking = StarStudioApiService();

  Future<void> fetchAllBookings() async {
    try {
      _isLoading = true;
      notifyListeners();

      final SharedPreferencesService sharedPrefs = SharedPreferencesService();
      String? token = await sharedPrefs.getTokenPref('userToken');
      print('Retrieved token: $token');

      if (token == null) {
        print('No token found');
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await _apiBooking.get(
        ApiConstant.getAllBookings,
      );

      response.headers['Authorization'] = 'Bearer $token';

      print("Response: $response");

      var apiResponse = ApiResponse.fromJson(response);
      if (apiResponse.status == true && apiResponse.data != null) {
        var bookingData = apiResponse.data['booking'] as List;
        _booking = bookingData
            .map((bookingJson) => Booking.fromJson(bookingJson))
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

 Future<void> postBooking(Booking booking) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await http.post(
        Uri.parse('${ApiConstant.localUrl}${ApiConstant.postBooking}'),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        _booking.add(Booking.fromJson(responseData['data']));
        notifyListeners();
      } else {
        handleSubmissionError('Failed to post booking: ${response.body}');
      }
    } catch (e) {
      handleSubmissionError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void handleSubmissionError(error) {
    print(error);
  }
}
