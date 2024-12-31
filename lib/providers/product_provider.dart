import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/services/product_service.dart';
import 'package:metal_gym_mobile_application/models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String _error = '';

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String get error => _error;

  // Fetch products from the API
  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = ''; // Reset previous error
    notifyListeners();  // Notify listeners before starting the request

    try {
      // Fetch products from API
      _products = await ProductService().fetchProducts();

      // Handle the successful product fetch
      _error = ''; // Clear any previous error if the fetch was successful
    } catch (e) {
      // Handle error case
      _error = e.toString();
      _products = []; // Clear products in case of error
    } finally {
      // Ensure _isLoading is set to false when fetching is done (success or failure)
      _isLoading = false;
      print("Fetched product count: ${_products.length}");
      notifyListeners();  // Notify listeners once data is fetched or error occurred
    }
  }
}
