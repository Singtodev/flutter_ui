// To parse this JSON data, do
//
//     final customerResponse = customerResponseFromJson(jsonString);

import 'dart:convert';

List<CustomerResponse> customerResponseFromJson(String str) =>
    List<CustomerResponse>.from(
        json.decode(str).map((x) => CustomerResponse.fromJson(x)));

String customerResponseToJson(List<CustomerResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerResponse {
  int? idx;
  String? fullname;
  String? phone;
  String? email;
  String? image;

  CustomerResponse({
    this.idx,
    this.fullname,
    this.phone,
    this.email,
    this.image,
  });

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      CustomerResponse(
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
