// To parse this JSON data, do
//
//     final tripDataResponse = tripDataResponseFromJson(jsonString);

import 'dart:convert';

TripDataResponse tripDataResponseFromJson(String str) =>
    TripDataResponse.fromJson(json.decode(str));

String tripDataResponseToJson(TripDataResponse data) =>
    json.encode(data.toJson());

class TripDataResponse {
  int? idx;
  String? name;
  String? country;
  String? coverimage;
  String? detail;
  int? price;
  int? duration;
  String? destinationZone;

  TripDataResponse({
    this.idx,
    this.name,
    this.country,
    this.coverimage,
    this.detail,
    this.price,
    this.duration,
    this.destinationZone,
  });

  factory TripDataResponse.fromJson(Map<String, dynamic> json) =>
      TripDataResponse(
        idx: json["idx"],
        name: json["name"],
        country: json["country"],
        coverimage: json["coverimage"],
        detail: json["detail"],
        price: json["price"],
        duration: json["duration"],
        destinationZone: json["destination_zone"],
      );

  Map<String, dynamic> toJson() => {
        "idx": idx,
        "name": name,
        "country": country,
        "coverimage": coverimage,
        "detail": detail,
        "price": price,
        "duration": duration,
        "destination_zone": destinationZone,
      };
}
