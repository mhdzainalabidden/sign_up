// ignore_for_file: file_names

import 'dart:convert';
import 'package:file_picker/file_picker.dart';

class MenuAddImageModel {
  int id;
  String arName;
  String enName;
  String arDescription;
  String enDescription;
  final PlatformFile photo;
  String type;
  String price;

  MenuAddImageModel({
    required this.id,
    required this.arName,
    required this.enName,
    required this.arDescription,
    required this.enDescription,
    required this.photo,
    required this.type,
    required this.price,
  });

  factory MenuAddImageModel.fromRawJson(String str) =>
      MenuAddImageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MenuAddImageModel.fromJson(Map<String, dynamic> json) =>
      MenuAddImageModel(
        id: json["id"],
        arName: json["ar_name"],
        enName: json["en_name"],
        arDescription: json["ar_description"],
        enDescription: json["en_description"],
        photo: PlatformFile(name: '', size: 0, bytes: null),
        type: json["type"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ar_name": arName,
    "en_name": enName,
    "ar_description": arDescription,
    "en_description": enDescription,
    // "photo": photo,
    "type": type,
    "price": price,
  };
}
