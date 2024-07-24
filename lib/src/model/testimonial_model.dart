import 'dart:convert';

class TestimonialsModel {
  TestimonialsModel({
    required this.data,
  });

  final Data data;

  factory TestimonialsModel.fromRawJson(String str) => TestimonialsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TestimonialsModel.fromJson(Map<String, dynamic> json) => TestimonialsModel(
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
        testimonials: List<Testimonial>.from(json["testimonials"].map((x) => Testimonial.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "testimonials": List<dynamic>.from(testimonials.map((x) => x.toJson())),
      };
}

class Testimonial {
  Testimonial({
    required this.fname,
    required this.lname,
    required this.review,
    required this.reviewImage,
  });

  final String fname;
  final String lname;
  final String review;
  final String reviewImage;

  factory Testimonial.fromJson(Map<String, dynamic> json) => Testimonial(
        fname: json["fname"],
        lname: json["lname"],
        review: json["review"],
        reviewImage: json["reviewImage"],
      );

  Map<String, dynamic> toJson() => {
        "fname": fname,
        "lname": lname,
        "review": review,
        "reviewImage": reviewImage,
      };
}
