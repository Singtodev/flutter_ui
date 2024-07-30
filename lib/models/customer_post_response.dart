// To parse this JSON data, do
//
//     final customerModelPost = customerModelPostFromJson(jsonString);

import 'dart:convert';

CustomerModelPost customerModelPostFromJson(String str) =>
    CustomerModelPost.fromJson(json.decode(str));

String customerModelPostToJson(CustomerModelPost data) =>
    json.encode(data.toJson());

class CustomerModelPost {
  String? message;
  String? error;
  Customer? customer;

  CustomerModelPost({
    this.message,
    this.error,
    this.customer,
  });

  factory CustomerModelPost.fromJson(Map<String, dynamic> json) =>
      CustomerModelPost(
        message: json["message"],
        error: json["error"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "customer": customer?.toJson(),
      };
}

class Customer {
  int? idx;
  String? fullname;
  String? phone;
  String? email;
  String? image;

  Customer({
    this.idx,
    this.fullname,
    this.phone,
    this.email,
    this.image,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        idx: json["idx"],
        fullname: json["fullname"],
        phone: json["phone"],
        email: json["email"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "idx": idx,
        "fullname": fullname,
        "phone": phone,
        "email": email,
        "image": image,
      };
}
