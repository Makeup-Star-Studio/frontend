import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:makeupstarstudio/src/config/global_config.dart';
import 'package:makeupstarstudio/src/model/response_model.dart';
import 'package:makeupstarstudio/src/services/jwt_service.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';


abstract class HttpRepo {
  Future<ApiResponse> get(String path, {bool requiresToken});
  Future<ApiResponse> post(String path, dynamic body, {bool requiresToken});
  Future<ApiResponse> patch(String path, dynamic body);
  Future<ApiResponse> delete(String path);
}

class HttpServices implements HttpRepo {
  Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(
        seconds: 30,
      ),
      baseUrl: GlobalConfig.baseUrl,
      responseType: ResponseType.json,
      contentType: ContentType.json.toString(),
      validateStatus: (status) => status! < 505,
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          bool requiresToken = options.extra['requiresToken'] ?? true;
          if (requiresToken) {
            SharedPreferencesService sharedPref = SharedPreferencesService();
            var token = await sharedPref.getStringPref('userData');
            print('Retrieved token: $token');

            if (token != null && token['token'] != null) {
              String tokenString = token['token'];
              print('tokenString--> $tokenString');
              bool isExpired = JwtDecoder.isExpired(tokenString);
              var remainingTime = JwtDecoder.getRemainingTime(tokenString);

              print('isExpired: $isExpired');
              print('remaining time: $remainingTime');
              print('token: $tokenString');

              if (isExpired) {
                // Utility.showExpirationDialog();

                return handler.reject(DioException(
                  requestOptions: options,
                  error: 'Session expired',
                ));
              } else {
                options.headers['Authorization'] = 'Bearer $tokenString';
              }
            }
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (response.statusCode == 401) {
            // Utility.showExpirationDialog();
          }

          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401) {
            // Utility.showExpirationDialog();
          }
          return handler.next(e);
        },
      ),
    );

  @override
  Future<ApiResponse> get(String path, {bool requiresToken = true}) async {
    try {
      Response response = await dio.get(
        path,
        options: Options(extra: {'requiresToken': requiresToken}),
      );
      var decodedResponse = json.decode(
        response.toString(),
      );

      // if (decodedResponse['status'] != "success") {
      // throw (decodedResponse['message']);
      // }
      return apiResponseFromJson(
        json.encode(
          decodedResponse,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> post(String path, dynamic body,
      {bool requiresToken = true}) async {
    try {
      Response response = await dio.post(
        path,
        data: body,
        options: Options(
          extra: {
            'requiresToken': requiresToken,
          },
        ),
      );

      // Handle redirection in status code 308
      if (response.statusCode == 308) {
        String? redirectionUrl = response.headers['location']?.first;

        print('redirected url: $redirectionUrl');
        if (redirectionUrl != null) {
          return await post(redirectionUrl, body, requiresToken: requiresToken);
        } else {
          throw DioException(
            requestOptions: response.requestOptions,
            error: 'Redirection URL not provided',
          );
        }
      }

      var decodedResponse = json.decode(
        response.toString(),
      );
      // if (decodedResponse['success'] == false) {
      //   throw (decodedResponse['message']);
      // }
      return apiResponseFromJson(
        json.encode(
          decodedResponse,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> patch(String path, dynamic body) async {
    try {
      //make body common in future
      Response response = await dio.patch(path, data: body);
      var decodedResponse = json.decode(
        response.toString(),
      );
      return apiResponseFromJson(
        json.encode(
          decodedResponse,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> delete(String path) async {
    try {
      //make body common in future
      Response response = await dio.post(path);
      var decodedResponse = json.decode(
        response.toString(),
      );
      return apiResponseFromJson(
        json.encode(
          decodedResponse,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
