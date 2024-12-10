import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/models/product.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts({String? searchTerm}) async {
    String consumerKey = dotenv.env['CLIENT_KEY'] ?? "Key not found!";
    String consumerSecret = dotenv.env['CLIENT_SECRET'] ?? "Key not found!";
    String baseUrl = dotenv.env['BASE_URL'] ?? "Base url not found!";

    String auth = base64Encode(utf8.encode('$consumerKey:$consumerSecret'));

    // Build the query URL
    String url = baseUrl;
    if (searchTerm != null && searchTerm.isNotEmpty) {
      url += '?search=${Uri.encodeComponent(searchTerm)}';
      print("SEARCH URL: $url");
    }else{
      url += "/products";
    }

    try {
      _isLoading = true;
      notifyListeners();

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Basic $auth',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        print("Fetched products: $jsonData"); // Debugging
        _products = jsonData.map((product) => Product.fromJson(product)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }

  }

  Future<void> searchProducts(String query) async {
    await fetchProducts(searchTerm: query);
  }

  void clearSearch() {
    _searchQuery = '';
    fetchProducts();
  }
}
