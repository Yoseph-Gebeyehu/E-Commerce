import 'dart:convert';

import 'package:e_commerce/api/api_response.dart';
import 'package:e_commerce/models/api_request.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  Future<ApiResponse> getProductList() async {
    String baseUrl = 'https://dummyjson.com/products';
    var url = Uri.parse(baseUrl);
    var response = await http.get(url);
    return ApiResponse.fromResponse(response);
  }

  Future<ApiResponse> postData(ApiRequest apiRequest) async {
    String baseUrl = "https://api.chapa.co/v1/transaction/initialize";
    String key = "CHASECK_TEST-KzqTmzYnjSL5UDnlA7YuiAZY3OoeujYo";

    var request = json.encode(apiRequest);

    var headers = {
      "Authorization": "Bearer $key",
      "Content-Type": "application/json"
    };
    http.Response response = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: request,
    );
    return ApiResponse.fromResponse(response);
  }
}
