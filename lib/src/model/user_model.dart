import 'dart:convert';

class UserModel {
  UserModel({
    required this.data,
  });

  final Data data;

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.user,
  });

  final List<User> user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": List<dynamic>.from(user.map((x) => x.toJson())),
      };
}

class User {
  User({
    this.id,
    required this.imageUrl,
    required this.fname,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.passwordConfirm,
    this.bio,
    this.location,
    this.passwordChangeAt,
    this.passwordResetToken,
    this.passwordResetTokenExpiry,
    required this.role,
    required this.failedAttempts,
  });

  final String? id;
  final String imageUrl;
  final String fname;
  final String username;
  final String email;
  final String phoneNumber;
  final String password;
  final String? passwordConfirm;
  final String? bio;
  final String? location;
  final DateTime? passwordChangeAt;
  final String? passwordResetToken;
  final DateTime? passwordResetTokenExpiry;
  final String role;
  final int failedAttempts;

  factory User.fromJson(Map<String, dynamic> json) => 
     User(
      id: json["id"],
      imageUrl: json["imageUrl"] ?? 'default.jpg',
      fname: json["fname"],
      username: json["username"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      password: json["password"] ?? '',
      passwordConfirm: json["passwordConfirm"] ?? '',
      bio: json["bio"] ?? '',
      location: json["location"] ?? '',
      passwordChangeAt: json["passwordChangeAt"] != null
          ? DateTime.parse(json["passwordChangeAt"])
          : null,
      passwordResetToken: json["passwordResetToken"],
      passwordResetTokenExpiry: json["passwordResetTokenExpiry"] != null
          ? DateTime.parse(json["passwordResetTokenExpiry"])
          : null,
      role: json["role"],
      failedAttempts: json["failedAttempts"] ?? 0,
    );
  
  Map<String, dynamic> toJson() => {
        "id": id,
        "imageUrl": imageUrl,
        "fname": fname,
        "username": username,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
        "passwordConfirm": passwordConfirm,
        "bio": bio,
        "location": location,
        "passwordChangeAt": passwordChangeAt?.toIso8601String(),
        "passwordResetToken": passwordResetToken,
        "passwordResetTokenExpiry": passwordResetTokenExpiry?.toIso8601String(),
        "role": role,
        "failedAttempts": failedAttempts,
      };
}
