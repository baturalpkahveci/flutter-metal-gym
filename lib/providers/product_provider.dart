import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/services/product_service.dart';
import 'package:metal_gym_mobile_application/models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _inStockProducts = [];
  bool _isLoading = false;
  String _error = '';

  List<Product> get products => _products;
  List<Product> get inStockProducts => _inStockProducts;
  bool get isLoading => _isLoading;
  String get error => _error;

  // Fetch products from the API
  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = ''; // Reset previous error
    notifyListeners();  // Notify listeners before starting the request

    try {
      _products = await ProductService().fetchProducts();
      // Filter in-stock products
      _inStockProducts = _products.where((product) => product.inStock).toList();
      _error = ''; // Clear any previous error if the fetch was successful
    } catch (e) {
      _error = e.toString();
      _products = []; // Clear products in case of error
    } finally {
      _isLoading = false;
      print("Fetched product count: ${_products.length}");
      notifyListeners();  // Notify listeners once data is fetched or error occurred
    }
  }
}
