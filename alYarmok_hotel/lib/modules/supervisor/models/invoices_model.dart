// ignore_for_file: constant_identifier_names

import 'dart:convert';

class InvoicesModel {
  bool success;
  List<Invoice> invoices;

  InvoicesModel({required this.success, required this.invoices});

  factory InvoicesModel.fromRawJson(String str) =>
      InvoicesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InvoicesModel.fromJson(Map<String, dynamic> json) => InvoicesModel(
    success: json["success"],
    invoices: List<Invoice>.from(
      json["invoices"].map((x) => Invoice.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "invoices": List<dynamic>.from(invoices.map((x) => x.toJson())),
  };
}

class Invoice {
  int id;
  String description;
  DateTime date;
  String price;
  Status status;
  ItemType itemType;
  int itemId;
  int userId;

  Invoice({
    required this.id,
    required this.description,
    required this.date,
    required this.price,
    required this.status,
    required this.itemType,
    required this.itemId,
    required this.userId,
  });

  factory Invoice.fromRawJson(String str) => Invoice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
    id: json["id"],
    description: json["description"],
    date: DateTime.parse(json["date"]),
    price: json["price"],
    status: statusValues.map[json["status"]]!,
    itemType: itemTypeValues.map[json["item_type"]]!,
    itemId: json["item_id"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "date": date.toIso8601String(),
    "price": price,
    "status": statusValues.reverse[status],
    "item_type": itemTypeValues.reverse[itemType],
    "item_id": itemId,
    "user_id": userId,
  };
}

enum Status { UNPAID, PAID, CANCELLED }

final statusValues = EnumValues({
  "unpaid": Status.UNPAID,
  "paid": Status.PAID,
  "cancelled": Status.CANCELLED,
});

enum ItemType { RESTAURANT }

final itemTypeValues = EnumValues({"restaurant": ItemType.RESTAURANT});

class EnumValues<T> {
  final Map<String, T> map;
  late final Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
