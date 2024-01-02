// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  int userId;
  int id;
  String title;
  String? body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}

class LoginData {
  final String email;
  final String password;

  LoginData({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class SignData {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  SignData({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
    };
  }
}

Get getFromJson(String str) => Get.fromJson(json.decode(str));

String getToJson(Get data) => json.encode(data.toJson());

class Get {
  List<Datum> data;

  Get({
    required this.data,
  });

  factory Get.fromJson(Map<String, dynamic> json) => Get(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String? uuid;
  final String name;
  final String logo;
  String? description;
  int? hasDiscount;
  int? discountType;
  String? discountValue;

  Datum({
    this.uuid,
    required this.name,
    required this.logo,
    this.description,
    this.hasDiscount,
    this.discountType,
    this.discountValue,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        uuid: json["uuid"],
        name: json["name"],
        logo: json["logo"],
        description: json["description"],
        hasDiscount: json["has_discount"],
        discountType: json["discount_type"],
        discountValue: json["discount_value"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "name": name,
        "logo": logo,
        "description": description,
        "has_discount": hasDiscount,
        "discount_type": discountType,
        "discount_value": discountValue,
      };
}

class Restaurant {
  final String? uuid;
  final String name;
  String? logo;
  final String description;
  final bool? hasDiscount;
  final int? discountType;
  final String? discountValue;

  Restaurant({
    this.uuid,
    required this.name,
    this.logo,
    required this.description,
    this.hasDiscount,
    this.discountType,
    this.discountValue,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      uuid: json['uuid'],
      name: json['name'],
      logo: json['logo'],
      description: json['description'],
      hasDiscount: json['has_discount'] == 1,
      discountType: json['discount_type'],
      discountValue: json['discount_value'],
    );
  }
}
