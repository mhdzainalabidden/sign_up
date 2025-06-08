import 'dart:convert';

class RegistrarModel {
  User user;
  String token;
  String message;

  RegistrarModel({
    required this.user,
    required this.token,
    required this.message,
  });

  factory RegistrarModel.fromRawJson(String str) =>
      RegistrarModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegistrarModel.fromJson(Map<String, dynamic> json) => RegistrarModel(
    user: User.fromJson(json["user"]),
    token: json["token"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "token": token,
    "message": message,
  };
}

class User {
  String name;
  String email;
  dynamic photo;
  String phone;
  int id;

  User({
    required this.name,
    required this.email,
    required this.photo,
    required this.phone,
    required this.id,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    email: json["email"],
    photo: json["photo"],
    phone: json["phone"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "photo": photo,
    "phone": phone,
    "id": id,
  };
}

// class User {
//   final int id;
//   final String email;
//   final String name;
//   final String role;
//   final String avatar;

//   User({
//     required this.id,
//     required this.email,
//     required this.name,
//     required this.role,
//     required this.avatar,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       email: json['email'],
//       name: json['name'],
//       role: json['role'],
//       avatar: json['avatar'],
//     );
//   }
// }
