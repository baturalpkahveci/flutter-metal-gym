import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/services/product_service.dart';
import 'package:metal_gym_mobile_application/models/product.dart';

class ProductProvider with ChangeNotifier {
  final ProductService productService = ProductService();
  List<Product> _products = [];
  bool _isLoading = false;
  String _error = '';

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String get error => _error;

  // Fetch products without any filters or sorting
  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _products = await productService.fetchProducts();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Client-side filter and sort
  void filterAndSortProducts({
    String category = 'all',
    String sortOrder = 'popular',
  }) {
    List<Product> filteredProducts = _products;

    // Filter by category if needed
    if (category != 'all') {
      filteredProducts = filteredProducts.where((product) {
        return product.categories.any((cat) => cat.slug == category);
      }).toList();
    }

    // Sort products based on selected order
    switch (sortOrder) {
      case 'alphabetical':
        filteredProducts.sort((a, b) => a.name.compareTo(b.name)); // Sort by name (alphabetical)
        break;
      case 'popular':
        filteredProducts.sort((a, b) => b.totalSales.compareTo(a.totalSales)); // Sort by most sold
        break;
      case 'rating':
        filteredProducts.sort((a, b) => b.averageRating.compareTo(a.averageRating)); // Sort by average rating
        break;
      case 'newest':
        filteredProducts.sort((a, b) => b.dateCreated.compareTo(a.dateCreated)); // Sort by newest
        break;
      case 'ascending':
        filteredProducts.sort((a, b) => a.price.compareTo(b.price)); // Sort by price ascending
        break;
      case 'descending':
        filteredProducts.sort((a, b) => b.price.compareTo(a.price)); // Sort by price descending
        break;
      default:
        break;
    }

    _products = filteredProducts;
    notifyListeners();
  }
}


