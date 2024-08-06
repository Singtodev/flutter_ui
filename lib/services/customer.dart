import 'package:flutter/material.dart';
import 'package:flutter_ui/models/customer_data_response.dart';
import 'package:http/http.dart' as http;
import '../configs//environment.dart';

class CustomerService {
  Future<CustomerDataResponse> getCustomer(String id) async {
    final response = await http.get(
      Uri.parse('${config['ENDPOINT']}/customers/$id'),
      headers: {"Content-Type": "application/json; charset=utf-8"},
    );
    if (response.statusCode == 200) {
      return customerDataResponseFromJson(response.body);
    } else {
      throw Exception('Failed to get user: ${response.statusCode}');
    }
  }

  Future<CustomerDataResponse> putCustomer(
      String id, CustomerDataResponse data) async {
    debugPrint('${config['ENDPOINT']}/customers/$id');
    final response = await http.put(
        Uri.parse('${config['ENDPOINT']}/customers/$id'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: customerDataResponseToJson(data));
    if (response.statusCode == 200) {
      return customerDataResponseFromJson(response.body);
    } else {
      throw Exception('Failed to put user: ${response.statusCode}');
    }
  }

  Future<void> deleteCustomer(String id) async {
    await http.delete(
      Uri.parse('${config['ENDPOINT']}/customers/$id'),
      headers: {"Content-Type": "application/json; charset=utf-8"},
    );
  }
}
