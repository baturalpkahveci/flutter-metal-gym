import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metal_gym_mobile_application/models/product.dart';

class ProductService {
  final String baseUrl = 'https://mgbackend-czhf.onrender.com'; // Replace with your server URL

  // Fetch products from the API
  Future<List<Product>> fetchAllProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    print("FetchProducts response length: ${response.contentLength}");

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      // Filter out products based on status and stock_status
      final filteredData = data.where((json) =>
      json['status'] == 'publish' && json['stock_status'] == 'instock');

      return filteredData.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Fetch products with pagination
  Future<List<Product>> fetchProducts({required int page, required int perPage}) async {
    final response = await http.get(Uri.parse('$baseUrl/products?page=$page&perPage=$perPage'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print("Products found: ${data.length}");
      // Filter out products based on status and stock_status
      final filteredData = data.where((json) =>
      json['status'] == 'publish' && json['stock_status'] == 'instock');
      print("Filtered products: ${filteredData.length}");
      return filteredData.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Search products with query
  Future<List<Product>> searchProducts(String query, int page, int perPage) async {
    final response = await http.get(Uri.parse('$baseUrl/api/products/search?query=$query&page=$page&perPage=$perPage'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Filter out products based on status and stock_status
      final filteredData = data.where((json) =>
      json['status'] == 'publish' && json['stock_status'] == 'instock');

      return filteredData.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search products');
    }
  }
}
