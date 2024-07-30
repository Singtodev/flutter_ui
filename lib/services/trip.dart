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
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }
}
