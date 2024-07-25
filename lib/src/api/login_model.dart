
import 'dart:convert';

LoginModel apiResponseFromJson(String str) => LoginModel.fromJson(json.decode(str));

String apiResponseToJson(LoginModel body) => json.encode(body.toJson());

class LoginModel {
  bool status;
  String token;
  Map<String, dynamic> data;
  String message;

  LoginModel({
    required this.status,
    required this.token,
    required this.data,
    required this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"] == "success",
        token: json["token"] ?? '',
        data: json["data"] ?? {},
        message: json["message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "status": status ? "success" : "fail",
        "token": token,
        "data": data,
        "message": message,
      };
}
