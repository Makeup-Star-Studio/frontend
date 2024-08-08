import 'dart:convert';

class UserModel {
    final String status;
    final Data data;

    UserModel({
        required this.status,
        required this.data,
    });

    factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    final User user;

    Data({
        required this.user,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
    };
}

class User {
  final String imageUrl;
  final String fname;
  final String username;
  final String email;
  final String phoneNumber;
  final String role;
  final int failedAttempts;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String bio;
  final String location;
  final String id;

  User({
    required this.imageUrl,
    required this.fname,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.failedAttempts,
    required this.createdAt,
    required this.updatedAt,
    required this.bio,
    required this.location,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    imageUrl: json["imageUrl"] ?? '', // Provide default value if null
    fname: json["fname"] ?? '', // Provide default value if null
    username: json["username"] ?? '', // Provide default value if null
    email: json["email"] ?? '', // Provide default value if null
    phoneNumber: json["phoneNumber"] ?? '', // Provide default value if null
    role: json["role"] ?? '', // Provide default value if null
    failedAttempts: json["failedAttempts"] ?? 0, // Provide default value if null
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(), // Handle null case
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(), // Handle null case
    bio: json["bio"] ?? '', // Provide default value if null
    location: json["location"] ?? '', // Provide default value if null
    id: json["id"] ?? '', // Provide default value if null
  );

  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl,
    "fname": fname,
    "username": username,
    "email": email,
    "phoneNumber": phoneNumber,
    "role": role,
    "failedAttempts": failedAttempts,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "bio": bio,
    "location": location,
    "id": id,
  };
}
