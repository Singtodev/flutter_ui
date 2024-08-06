import 'package:flutter_ui/models/trip_data_response.dart';
import 'package:flutter_ui/models/trip_response.dart';
import 'package:http/http.dart' as http;
import '../configs//environment.dart';

class TripService {
  Future<List<TripResponse>> getTrips() async {
    final response = await http.get(
      Uri.parse('${config['ENDPOINT']}/trips'),
      headers: {"Content-Type": "application/json; charset=utf-8"},
    );
    if (response.statusCode == 200) {
      return tripResponseFromJson(response.body);
    } else {
      throw Exception('Failed to get trips: ${response.statusCode}');
    }
  }

  Future<TripDataResponse> getTrip(String id) async {
    final response = await http.get(
      Uri.parse('${config['ENDPOINT']}/trips/$id'),
      headers: {"Content-Type": "application/json; charset=utf-8"},
    );
    if (response.statusCode == 200) {
      return tripDataResponseFromJson(response.body);
    } else {
      throw Exception('Failed to get trip: ${response.statusCode}');
    }
  }
}
