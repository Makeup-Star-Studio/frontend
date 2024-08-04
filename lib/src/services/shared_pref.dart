import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _prefs;

  Future<void> _init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> setStringPref(String key, dynamic value) async {
    try {
      await _init();
      String stringValue = value is String ? value : json.encode(value);
      await _prefs?.setString(key, stringValue);
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> getStringPref(String key) async {
    await _init();
    if (_prefs?.containsKey(key) ?? false) {
      final value = _prefs?.getString(key);
      if (value != null) {
        return json.decode(value);
      }
    }
    return null;
  }

  Future<String?> getTokenPref(String key) async {
    await _init();
    if (_prefs?.containsKey(key) ?? false) {
      return _prefs?.getString(key);
    }
    return null;
  }



   Future<void> logout(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);  
  }



  Future<void> setBoolPref(String key, bool value) async {
    await _init();
    await _prefs?.setBool(key, value);
  }

  Future<bool> getBoolPref(String key) async {
    await _init();
    return _prefs?.getBool(key) ?? false;
  }

  Future<void> deleteSharedPref(dynamic key) async {
    await _init();
    if (key is String) {
      if (_prefs?.containsKey(key) ?? false) {
        await _prefs?.remove(key);
      }
    } else if (key is List<String>) {
      for (var element in key) {
        if (_prefs?.containsKey(element) ?? false) {
          await _prefs?.remove(element);
        }
      }
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
