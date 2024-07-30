// To parse this JSON data, do
//
//     final customerCreatedResponse = customerCreatedResponseFromJson(jsonString);

import 'dart:convert';

CustomerCreatedResponse customerCreatedResponseFromJson(String str) =>
    CustomerCreatedResponse.fromJson(json.decode(str));

String customerCreatedResponseToJson(CustomerCreatedResponse data) =>
    json.encode(data.toJson());

class CustomerCreatedResponse {
  String? message;
  int? id;

  CustomerCreatedResponse({
    this.message,
    this.id,
  });

  factory CustomerCreatedResponse.fromJson(Map<String, dynamic> json) =>
      CustomerCreatedResponse(
        message: json["message"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "id": id,
      };
}
