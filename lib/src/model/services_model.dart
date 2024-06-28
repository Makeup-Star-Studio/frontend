import 'dart:convert';

class ServicesModel {
  ServicesModel({
    required this.data,
  });

  final Data data;

  factory ServicesModel.fromRawJson(String str) => ServicesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.services,
  });

  final List<Service> services;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
      };
}

class Service {
  Service({
    required this.title,
    required this.price,
    required this.category,
  });

  final String title;
  final double price;
  final String category;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        title: json["title"],
        price: json["price"].toDouble(),
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "category": category,
      };
}
