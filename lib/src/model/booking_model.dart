import 'dart:convert';

class BookingModel {
  // final String status;
  final Data data;

  BookingModel({
    // required this.status,
    required this.data,
  });

  factory BookingModel.fromRawJson(String str) =>
      BookingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        // status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        // "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.bookings,
  });
  final List<Booking> bookings;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookings: List<Booking>.from(
            json["bookings"].map((x) => Booking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bookings": List<dynamic>.from(bookings.map((x) => x.toJson())),
      };
}

class Booking {
  Booking({
    this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.phoneNumber,
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
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String fname;
  final String lname;
  final String email;
  final String phoneNumber;
  final DateTime eventDate;
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
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json['id'],
        fname: json['fname'],
        lname: json['lname'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        eventDate: DateTime.parse(json['eventDate']),
        eventType: List<String>.from(json['eventType']),
        serviceType: List<String>.from(json['serviceType']),
        eventLocation: json['eventLocation'],
        totalPeopleMakeup: json['totalPeopleMakeup'],
        totalPeopleHair: json['totalPeopleHair'],
        totalPeopleHenna: json['totalPeopleHenna'],
        totalPeopleDraping: json['totalPeopleDraping'],
        howDidYouHear: (json['howDidYouHear']),
        premiumService: (json['premiumService']),
        servicePricing: List<String>.from(json['servicePricing']),
        addedQuestionsOrInfo: json['addedQuestionsOrInfo'] ?? "",
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        // 'id': id,
        'fname': fname,
        'lname': lname,
        'email': email,
        'phoneNumber': phoneNumber,
        'eventDate': eventDate.toIso8601String(),
        'eventType': eventType,
        'serviceType': serviceType,
        'eventLocation': eventLocation,
        'totalPeopleMakeup': totalPeopleMakeup,
        'totalPeopleHair': totalPeopleHair,
        'totalPeopleHenna': totalPeopleHenna,
        'totalPeopleDraping': totalPeopleDraping,
        'howDidYouHear': howDidYouHear,
        'premiumService': premiumService,
        'servicePricing': servicePricing,
        'addedQuestionsOrInfo': addedQuestionsOrInfo ?? "",
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
