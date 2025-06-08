import 'dart:convert';

class MenuModel {
  int id;
  String arName;
  String enName;
  String arDescription;
  String enDescription;
  String photo;
  String type;
  String price;

  MenuModel({
    required this.id,
    required this.arName,
    required this.enName,
    required this.arDescription,
    required this.enDescription,
    required this.photo,
    required this.type,
    required this.price,
  });

  factory MenuModel.fromRawJson(String str) =>
      MenuModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
    id: json["id"],
    arName: json["ar_name"],
    enName: json["en_name"],
    arDescription: json["ar_description"],
    enDescription: json["en_description"],
    photo: json["photo"],
    type: json["type"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ar_name": arName,
    "en_name": enName,
    "ar_description": arDescription,
    "en_description": enDescription,
    "photo": photo,
    "type": type,
    "price": price,
  };
}
