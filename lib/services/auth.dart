import 'package:flutter_ui/models/customer_created_response.dart';
import 'package:flutter_ui/models/customer_post_body.dart';
import 'package:flutter_ui/models/modelA.dart';
import 'package:http/http.dart' as http;
import '../configs//environment.dart';
import 'package:flutter_ui/models/customer_post_response.dart';
import 'package:flutter_ui/models/customer_login_post_request.dart';

class AuthenticationService {
  Future<CustomerLoginResponse> login(bodyData) async {
    final response = await http.post(
        Uri.parse('${config['ENDPOINT']}/customers/login'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: customerLoginPostRequestToJson(bodyData));

    if (response.statusCode == 200) {
      return customerLoginResponseFromJson(response.body);
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }

  Future<CustomerCreatedResponse> register(bodyData) async {
    var response = await http.post(
      Uri.parse('${config['ENDPOINT']}/customers'),
      headers: {"Content-Type": "application/json; charset=utf-8"},
      body: customerPostBodyToJson(bodyData),
    );
    if (response.statusCode == 200) {
      return customerCreatedResponseFromJson(response.body);
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }
}
