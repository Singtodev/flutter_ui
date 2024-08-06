// To parse this JSON data, do
//
//     final customerDataResponse = customerDataResponseFromJson(jsonString);

import 'dart:convert';

CustomerDataResponse customerDataResponseFromJson(String str) =>
    CustomerDataResponse.fromJson(json.decode(str));

String customerDataResponseToJson(CustomerDataResponse data) =>
    json.encode(data.toJson());

class CustomerDataResponse {
  int? idx;
  String? fullname;
  String? phone;
  String? email;
  String? image;

  CustomerDataResponse({
    this.idx,
    this.fullname,
    this.phone,
    this.email,
    this.image,
  });

  factory CustomerDataResponse.fromJson(Map<String, dynamic> json) =>
      CustomerDataResponse(
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
