import 'dart:convert';

class TestimonialsModel {
  TestimonialsModel({
    required this.data,
  });

  final Data data;

  factory TestimonialsModel.fromRawJson(String str) =>
      TestimonialsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TestimonialsModel.fromJson(Map<String, dynamic> json) =>
      TestimonialsModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.testimonials,
  });

  final List<Testimonial> testimonials;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        testimonials: List<Testimonial>.from(
            json["testimonials"].map((x) => Testimonial.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "testimonials": List<dynamic>.from(testimonials.map((x) => x.toJson())),
      };
}

class Testimonial {
  Testimonial({
    this.id,
    required this.fname,
    required this.lname,
    required this.review,
    this.reviewImage, // Now a filename
  });

  final String? id;
  final String fname;
  final String lname;
  final String review;
  final String? reviewImage; // Update to String

  // static const String baseUrl = "http://localhost:3001/testimonial/";

  factory Testimonial.fromJson(Map<String, dynamic> json) {
    return Testimonial(
      id: json["id"] ?? "",
      fname: json["fname"],
      lname: json["lname"],
      review: json["review"],
      reviewImage: json["reviewImage"] ?? "", // Just a filename
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "fname": fname,
        "lname": lname,
        "review": review,
        "reviewImage": reviewImage ?? "", // Just a filename
      };

  // // Construct the image URL
  // String get reviewImageUrl => '$baseUrl$reviewImage';
}
