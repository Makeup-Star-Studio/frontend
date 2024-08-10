import 'dart:convert';

class ServicesModel {
  ServicesModel({
    required this.data,
  });

  final Data data;

  factory ServicesModel.fromRawJson(String str) =>
      ServicesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    // Check if 'data' key exists and is not null
    final dataJson = json['data'] as Map<String, dynamic>?;
    return ServicesModel(
      data: Data.fromJson(dataJson ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.services,
  });

  final List<Service> services;

  factory Data.fromJson(Map<String, dynamic> json) {
    // Check if 'services' key exists and is not null
    final servicesJson = json['services'] as List<dynamic>?;
    return Data(
      services: servicesJson != null
          ? List<Service>.from(servicesJson.map((x) => Service.fromJson(x as Map<String, dynamic>)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
      };
}

class Service {
  Service({
    this.id,
    required this.title,
    required this.price,
    required this.category,
    this.image,
  });

  final String? id;
  final String title;
  final double price;
  final String category;
  final String? image;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"] as String?,
        title: json["title"] as String? ?? '',
        price: (json["price"] as num).toDouble(),
        category: json["category"] as String? ?? '',
        image: json["image"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "category": category,
        "image": image,
      };
}
