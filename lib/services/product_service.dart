import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metal_gym_mobile_application/models/product.dart';

class ProductService {
  final String baseUrl = 'https://mgbackend-czhf.onrender.com'; // Replace with your server URL

  // Fetch products from the API
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    print("FetchProducts response length: ${response.contentLength}");

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
