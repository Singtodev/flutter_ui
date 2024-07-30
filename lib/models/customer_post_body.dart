// To parse this JSON data, do
//
//     final customerPostBody = customerPostBodyFromJson(jsonString);

import 'dart:convert';

CustomerPostBody customerPostBodyFromJson(String str) =>
    CustomerPostBody.fromJson(json.decode(str));

String customerPostBodyToJson(CustomerPostBody data) =>
    json.encode(data.toJson());

class CustomerPostBody {
  String? fullname;
  String? phone;
  String? password;
  String? email;
  String? image;

  CustomerPostBody({
    this.fullname,
    this.phone,
    this.password,
    this.email,
    this.image,
  });

  factory CustomerPostBody.fromJson(Map<String, dynamic> json) =>
      CustomerPostBody(
        fullname: json["fullname"],
        phone: json["phone"],
        password: json["password"],
        email: json["email"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "phone": phone,
        "password": password,
        "email": email,
        "image": image,
      };
}
