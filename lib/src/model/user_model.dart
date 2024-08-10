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
  final User admin;

  Data({
    required this.admin,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    admin: User.fromJson(json["admin"]),
  );

  Map<String, dynamic> toJson() => {
    "admin": admin.toJson(),
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
  final DateTime passwordChangeAt;
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
    required this.passwordChangeAt,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    imageUrl: json["imageUrl"] ?? '',
    fname: json["fname"] ?? '',
    username: json["username"] ?? '',
    email: json["email"] ?? '',
    phoneNumber: json["phoneNumber"] ?? '',
    role: json["role"] ?? '',
    failedAttempts: json["failedAttempts"] ?? 0,
    createdAt: DateTime.parse(json["createdAt"] ?? DateTime.now().toIso8601String()),
    updatedAt: DateTime.parse(json["updatedAt"] ?? DateTime.now().toIso8601String()),
    bio: json["bio"] ?? '',
    location: json["location"] ?? '',
    passwordChangeAt: DateTime.parse(json["passwordChangeAt"] ?? DateTime.now().toIso8601String()),
    id: json["id"] ?? '',
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
    "passwordChangeAt": passwordChangeAt.toIso8601String(),
    "id": id,
  };
}
