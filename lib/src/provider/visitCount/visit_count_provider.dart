// visit_provider.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:makeupstarstudio/src/utils/api_constant.dart';

class VisitProvider with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  Future<void> fetchVisitCount() async {
    final response =
        await http.get(Uri.parse('${ApiConstant.localUrl}/api/visit'));
    if (response.statusCode == 200) {
      _count = json.decode(response.body)['count'];
      notifyListeners();
    }
  }

  Future<void> increaseVisitCount() async {
    final response =
        await http.post(Uri.parse('${ApiConstant.localUrl}/api/visit'));
    if (response.statusCode == 200) {
      _count = json.decode(response.body)['count'];
      notifyListeners();
    }
  }
}
