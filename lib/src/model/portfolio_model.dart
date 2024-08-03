import 'dart:convert';

class PortfolioModel {
  PortfolioModel({
    required this.data,
  });

  final PortfolioData data;

  factory PortfolioModel.fromRawJson(String str) =>
      PortfolioModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PortfolioModel.fromJson(Map<String, dynamic> json) =>
      PortfolioModel(
        data: PortfolioData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class PortfolioData {
  PortfolioData({
    required this.portfolio,
  });

  final List<Portfolio> portfolio;

  factory PortfolioData.fromJson(Map<String, dynamic> json) => PortfolioData(
        portfolio: List<Portfolio>.from(
            json["portfolio"].map((x) => Portfolio.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "portfolio": List<dynamic>.from(portfolio.map((x) => x.toJson())),
      };
}

class Portfolio {
  Portfolio({
    this.id,
    required this.category,
    required this.portfolioImage,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final String category;
  final List<PortfolioImage> portfolioImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
        id: json["id"],
        category: json["category"],
        portfolioImage: List<PortfolioImage>.from(
            json["portfolioImage"].map((x) => PortfolioImage.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "portfolioImage":
            List<dynamic>.from(portfolioImage.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class PortfolioImage {
  PortfolioImage({
    this.id,
    required this.filename,
  });

  final String? id;
  final String filename;

  factory PortfolioImage.fromJson(Map<String, dynamic> json) => PortfolioImage(
        id: json["id"],
        filename: json["filename"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "filename": filename,
      };
}
