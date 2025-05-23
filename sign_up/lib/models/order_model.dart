import 'dart:convert';

class OrderModel {
  bool success;
  List<Datum> data;

  OrderModel({required this.success, required this.data});

  factory OrderModel.fromRawJson(String str) =>
      OrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  int? tableNumber;
  int? roomNumber;
  int? numberOfPeople;
  DateTime preferredTime;
  String tablePrice;
  String orderType;
  String status;
  DateTime? reservationEndTime;
  int bookedDuration;
  String totalPrice;
  int userId;
  dynamic approvedOrRejectedBy;
  User user;
  List<OrderItem> orderItems;

  Datum({
    required this.id,
    this.tableNumber,
    this.roomNumber,
    this.numberOfPeople,
    required this.preferredTime,
    required this.tablePrice,
    required this.orderType,
    required this.status,
    this.reservationEndTime,
    required this.bookedDuration,
    required this.totalPrice,
    required this.userId,
    required this.approvedOrRejectedBy,
    required this.user,
    required this.orderItems,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    tableNumber: json["table_number"],
    roomNumber: json["room_number"],
    numberOfPeople: json["number_of_people"],
    preferredTime: DateTime.parse(json["preferred_time"]),
    tablePrice: json["table_price"],
    orderType: json["order_type"],
    status: json["status"],
    reservationEndTime:
        json["reservation_end_time"] != null
            ? DateTime.parse(json["reservation_end_time"])
            : null,
    bookedDuration: json["booked_duration"],
    totalPrice: json["total_price"],
    userId: json["user_id"],
    approvedOrRejectedBy: json["approved_or_rejected_by"],
    user: User.fromJson(json["user"]),
    orderItems: List<OrderItem>.from(
      json["order_items"].map((x) => OrderItem.fromJson(x)),
    ),
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "table_number": tableNumber,
    "room_number": roomNumber,
    "number_of_people": numberOfPeople,
    "preferred_time": preferredTime.toIso8601String(),
    "table_price": tablePrice,
    "order_type": orderType,
    "status": status,
    "reservation_end_time": reservationEndTime?.toIso8601String(),
    "booked_duration": bookedDuration,
    "total_price": totalPrice,
    "user_id": userId,
    "approved_or_rejected_by": approvedOrRejectedBy,
    "user": user.toJson(),
    "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
  };
}

class OrderItem {
  int id;
  int quantity;
  String totalPrice;
  int restaurantOrderId;
  int menuItemId;
  MenuItem menuItem;

  OrderItem({
    required this.id,
    required this.quantity,
    required this.totalPrice,
    required this.restaurantOrderId,
    required this.menuItemId,
    required this.menuItem,
  });

  factory OrderItem.fromRawJson(String str) =>
      OrderItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["id"],
    quantity: json["quantity"],
    totalPrice: json["total_price"],
    restaurantOrderId: json["restaurant_order_id"],
    menuItemId: json["menu_item_id"],
    menuItem: MenuItem.fromJson(json["menu_item"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "total_price": totalPrice,
    "restaurant_order_id": restaurantOrderId,
    "menu_item_id": menuItemId,
    "menu_item": menuItem.toJson(),
  };
}

class MenuItem {
  int id;
  String arName;
  String enName;
  String arDescription;
  String enDescription;
  String photo;
  String type;
  String price;

  MenuItem({
    required this.id,
    required this.arName,
    required this.enName,
    required this.arDescription,
    required this.enDescription,
    required this.photo,
    required this.type,
    required this.price,
  });

  factory MenuItem.fromRawJson(String str) =>
      MenuItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
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

class User {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String phone;
  dynamic photo;
  String role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.phone,
    required this.photo,
    required this.role,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    phone: json["phone"],
    photo: json["photo"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "phone": phone,
    "photo": photo,
    "role": role,
  };
}
