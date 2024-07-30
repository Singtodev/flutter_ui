// To parse this JSON data, do
//
//     final customerLoginResponse = customerLoginResponseFromJson(jsonString);

import 'dart:convert';

CustomerLoginResponse customerLoginResponseFromJson(String str) => CustomerLoginResponse.fromJson(json.decode(str));

String customerLoginResponseToJson(CustomerLoginResponse data) => json.encode(data.toJson());

class CustomerLoginResponse {
    String? message;
    Customer? customer;

    CustomerLoginResponse({
        this.message,
        this.customer,
    });

    factory CustomerLoginResponse.fromJson(Map<String, dynamic> json) => CustomerLoginResponse(
        message: json["message"],
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
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
