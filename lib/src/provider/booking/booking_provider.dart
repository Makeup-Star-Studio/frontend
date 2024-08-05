import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:makeupstarstudio/src/model/booking_model.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';

class BookingProvider extends ChangeNotifier {
  List<Booking> _booking = [];

  List<Booking> get booking => _booking;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

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

      final response = await http.get(
        Uri.parse('${ApiConstant.localUrl}${ApiConstant.getAllBookings}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // print uri
      print('${ApiConstant.localUrl}${ApiConstant.getAllBookings}');

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        var apiResponse = jsonDecode(response.body);

        if (apiResponse['status'] == 'success' && apiResponse['data'] != null) {
          var bookingData = apiResponse['data'] as List;
          _booking = bookingData
              .map((bookingJson) => Booking.fromJson(bookingJson))
              .toList();
        } else {
          _booking = [];
        }
      } else {
        _booking = [];
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

      final bookingData = booking.toJson();
        final response = await http.post(
        Uri.parse('${ApiConstant.localUrl}/api/booking/'),
        body: json.encode(bookingData),
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

   /*---------------------------------Delete Booking---------------------------------*/

  Future<void> deleteBooking(String id) async {
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
        Uri.parse('${ApiConstant.localUrl}/api/booking/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 204) {
        _booking.removeWhere((booking) => booking.id == id);
        await fetchAllBookings();
      } else {
        final responseBody = json.decode(response.body);
        throw Exception('Failed to delete booking: ${responseBody['message']}');
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
