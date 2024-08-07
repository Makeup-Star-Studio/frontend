import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:makeupstarstudio/src/model/booking_model.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';

class BookingProvider extends ChangeNotifier {
  List<Booking> _bookings = [];

  List<Booking> get bookings => _bookings;

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
          _bookings = bookingData
              .map((bookingJson) => Booking.fromJson(bookingJson))
              .toList();
          _bookings = _bookings.reversed.toList();
        } else {
          _bookings = [];
        }
      } else {
        _bookings = [];
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

  Future<void> postBooking(Booking newBooking) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await http.post(
        Uri.parse('${ApiConstant.localUrl}${ApiConstant.postBooking}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(newBooking.toJson()),
      );

      print('${ApiConstant.localUrl}${ApiConstant.postBooking}');
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 201) {
        var apiResponse = jsonDecode(response.body);

        if (apiResponse['status'] == 'success' && apiResponse['data'] != null) {
          var booking = Booking.fromJson(apiResponse);
          _bookings.add(booking);
        }
      } else {
        print('Failed to post booking. Status code: ${response.statusCode}');
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
        _bookings.removeWhere((booking) => booking.id == id);
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
