import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts({String? searchTerm}) async {
    const String consumerKey = 'your_consumer_key';
    const String consumerSecret = 'your_consumer_secret';
    const String baseUrl = 'https://metalgymturkey.com/wp-json/wc/v3/products';

    String auth = base64Encode(utf8.encode('$consumerKey:$consumerSecret'));

    // Build the query URL
    String url = baseUrl;
    if (searchTerm != null && searchTerm.isNotEmpty) {
      url += '?search=${Uri.encodeComponent(searchTerm)}';
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
        _products = jsonData.map((product) => Product.fromJson(product)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
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
