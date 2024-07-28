import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences prefs = '' as SharedPreferences;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  setStringPref(String key, value) async {
    try {
      await init();
      String stringValue = value is String ? value : json.encode(value);
      await prefs.setString(key, stringValue);
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> getStringPref(String key) async {
    await init();
    if (prefs.containsKey(key)) {
      final value = prefs.getString(key);
      if (value != null) {
        return json.decode(value);
      }
      return null;
    } else {
      return null;
    }
  }

  setBoolPref(String key, bool value) async {
    await init();
    await prefs.setBool(key, value);
  }

  getBoolPref(String key) async {
    await init();
    if (prefs.containsKey(key)) {
      return prefs.getBool(key) ?? false;
    } else {
      return false;
    }
  }

  deleteSharedPref(dynamic key) async {
    await init();
    if (key is String) {
      if (prefs.containsKey(key)) {
        await prefs.remove(key);
      }
    } else {
      key.forEach((element) async {
        if (prefs.containsKey(element)) {
          await prefs.remove(element);
        }
      });
    }
  }
}


// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferencesService {
//   static SharedPreferences? _prefs;

//   Future<void> init() async {
//     if (_prefs == null) {
//       _prefs = await SharedPreferences.getInstance();
//     }
//   }

//   Future<void> setStringPref(String key, dynamic value) async {
//     await init();
//     String stringValue = value is String ? value : json.encode(value);
//     await _prefs?.setString(key, stringValue);
//   }

//   Future<dynamic> getStringPref(String key) async {
//     await init();
//     if (_prefs?.containsKey(key) ?? false) {
//       final value = _prefs?.getString(key);
//       if (value != null) {
//         try {
//           return json.decode(value);
//         } catch (e) {
//           return value; // Return as string if not JSON
//         }
//       }
//     }
//     return null;
//   }

//   Future<void> setBoolPref(String key, bool value) async {
//     await init();
//     await _prefs?.setBool(key, value);
//   }

//   Future<bool> getBoolPref(String key) async {
//     await init();
//     return _prefs?.getBool(key) ?? false;
//   }

//   Future<void> deleteSharedPref(dynamic key) async {
//     await init();
//     if (key is String) {
//       if (_prefs?.containsKey(key) ?? false) {
//         await _prefs?.remove(key);
//       }
//     } else if (key is List<String>) {
//       for (var element in key) {
//         if (_prefs?.containsKey(element) ?? false) {
//           await _prefs?.remove(element);
//         }
//       }
//     }
//   }
// }
