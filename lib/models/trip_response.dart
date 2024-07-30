// To parse this JSON data, do
//
//     final tripResponse = tripResponseFromJson(jsonString);

import 'dart:convert';

List<TripResponse> tripResponseFromJson(String str) => List<TripResponse>.from(
    json.decode(str).map((x) => TripResponse.fromJson(x)));

String tripResponseToJson(List<TripResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TripResponse {
  int? idx;
  String? name;
  String? country;
  String? coverimage;
  String? detail;
  int? price;
  int? duration;
  DestinationZone? destinationZone;

  TripResponse({
    this.idx,
    this.name,
    this.country,
    this.coverimage,
    this.detail,
    this.price,
    this.duration,
    this.destinationZone,
  });

  factory TripResponse.fromJson(Map<String, dynamic> json) => TripResponse(
        idx: json["idx"],
        name: json["name"],
        country: json["country"],
        coverimage: json["coverimage"],
        detail: json["detail"],
        price: json["price"],
        duration: json["duration"],
        destinationZone: destinationZoneValues.map[json["destination_zone"]]!,
      );

  Map<String, dynamic> toJson() => {
        "idx": idx,
        "name": name,
        "country": country,
        "coverimage": coverimage,
        "detail": detail,
        "price": price,
        "duration": duration,
        "destination_zone": destinationZoneValues.reverse[destinationZone],
      };
}

enum DestinationZone { DESTINATION_ZONE, EMPTY, FLUFFY, PURPLE }

final destinationZoneValues = EnumValues({
  "เอเชียตะวันออกเฉียงใต้": DestinationZone.DESTINATION_ZONE,
  "ยุโรป": DestinationZone.EMPTY,
  "ประเทศไทย": DestinationZone.FLUFFY,
  "เอเชีย": DestinationZone.PURPLE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
