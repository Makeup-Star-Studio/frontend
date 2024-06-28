import 'dart:convert';

ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse body) => json.encode(body.toJson());

class ApiResponse {
  bool? status;
  dynamic data;
  String token;
  String message;
  dynamic package;
  dynamic transactions;
  String code;
  String messages;
  String error;

  ApiResponse({
    this.status,
    this.data,
    this.package,
    this.token = '',
    this.message = '',
    this.transactions,
    this.code = '',
    this.messages = '',
    this.error = '',
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        status: json["status"],
        data: json["data"],
        package: json['Packages'],
        transactions: json["Transactions"],
        token: json["token"] ?? "",
        message: json["message"] == null || json['message'] == ""
            ? ''
            : json['message'],
        code: json["Code"] ?? "",
        messages: json["Message"] ?? "",
        error: json["exception"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
        "Packages": package,
        "Transactions": transactions,
        "token": token,
        "message": message,
        "Code": code,
        "Message": messages,
        "exception": error,
      };
}
