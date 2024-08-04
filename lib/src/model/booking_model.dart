import 'dart:convert';

class Booking {
  Booking({
    this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.phoneNumber,
    this.socialMedia,
    required this.eventDate,
    required this.eventType,
    required this.serviceType,
    required this.eventLocation,
    required this.totalPeopleMakeup,
    required this.totalPeopleHair,
    required this.totalPeopleHenna,
    required this.totalPeopleDraping,
    required this.howDidYouHear,
    required this.premiumService,
    required this.servicePricing,
    this.addedQuestionsOrInfo,
  });

  final String? id;
  final String fname;
  final String lname;
  final String email;
  final String phoneNumber;
  final String? socialMedia;
  final DateTime eventDate; // This is a DateTime object now
  final List<String> eventType;
  final List<String> serviceType;
  final String eventLocation;
  final int totalPeopleMakeup;
  final int totalPeopleHair;
  final int totalPeopleHenna;
  final int totalPeopleDraping;
  final String howDidYouHear;
  final String premiumService;
  final List<String> servicePricing;
  final String? addedQuestionsOrInfo;

  factory Booking.fromRawJson(String str) => Booking.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        fname: json["fname"],
        lname: json["lname"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        socialMedia: json["socialMedia"],
        eventDate:
            DateTime.parse(json["eventDate"]), // Parse date string to DateTime
        eventType: List<String>.from(json["eventType"]),
        serviceType: List<String>.from(json["serviceType"]),
        eventLocation: json["eventLocation"],
        totalPeopleMakeup: json["totalPeopleMakeup"],
        totalPeopleHair: json["totalPeopleHair"],
        totalPeopleHenna: json["totalPeopleHenna"],
        totalPeopleDraping: json["totalPeopleDraping"],
        howDidYouHear: json["howDidYouHear"],
        premiumService: json["premiumService"],
        servicePricing: List<String>.from(json["servicePricing"]),
        addedQuestionsOrInfo: json["addedQuestionsOrInfo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fname": fname,
        "lname": lname,
        "email": email,
        "phoneNumber": phoneNumber,
        "socialMedia": socialMedia,
        "eventDate":
            eventDate.toIso8601String(), // Convert DateTime to ISO 8601 String
        "eventType": List<dynamic>.from(eventType.map((x) => x)),
        "serviceType": List<dynamic>.from(serviceType.map((x) => x)),
        "eventLocation": eventLocation,
        "totalPeopleMakeup": totalPeopleMakeup,
        "totalPeopleHair": totalPeopleHair,
        "totalPeopleHenna": totalPeopleHenna,
        "totalPeopleDraping": totalPeopleDraping,
        "howDidYouHear": howDidYouHear,
        "premiumService": premiumService,
        "servicePricing": List<dynamic>.from(servicePricing.map((x) => x)),
        "addedQuestionsOrInfo": addedQuestionsOrInfo,
      };
}
