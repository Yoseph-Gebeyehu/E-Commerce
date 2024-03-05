import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiResponse {
  int? status;
  dynamic body;

  ApiResponse({
    required this.status,
    this.body,
  });

  factory ApiResponse.fromResponse(http.Response response) {
    int code = response.statusCode;
    String responseBody = response.body;

    dynamic decodedBody;
    try {
      decodedBody = jsonDecode(responseBody);
      // print(decodedBody);
    } catch (e) {
      decodedBody = null;
    }

    return ApiResponse(
      status: code,
      body: decodedBody,
    );
  }
}
