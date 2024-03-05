import 'package:e_commerce/api/api_response.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  Future<ApiResponse> getProductList() async {
    String baseUrl = 'https://dummyjson.com/products';
    var url = Uri.parse(baseUrl);
    var response = await http.get(url);
    return ApiResponse.fromResponse(response);
  }
}
