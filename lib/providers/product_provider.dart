import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/services/product_service.dart';
import 'package:metal_gym_mobile_application/models/product.dart';

class ProductProvider with ChangeNotifier {
  final ProductService productService = ProductService();
  List<Product> _products = [];
  bool _isLoading = false;
  String _error = '';
  int _currentPage = 1;
  final int _perPage = 20;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String get error => _error;

  // Fetch products without any filters or sorting
  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _products = await productService.fetchProducts(page: _currentPage, perPage: _perPage);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Fetch products by search query and page
  Future<void> searchProducts(String query, {int page = 1}) async {
    if (page == 1) {
      _products = []; // Reset the list if a new search query is issued
    }

    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final fetchedProducts = await productService.searchProducts(query, page, _perPage);
      _products.addAll(fetchedProducts); // Add fetched products to the list
    } catch (e) {
      _error = 'Error fetching products: ${e.toString()}';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Load next page of products
  Future<void> loadNextPage(String query) async {
    _currentPage++;
    await searchProducts(query, page: _currentPage); // Fetch products from the next page
  }

  void resetPageAndProducts() {
    _currentPage = 1;
    _products = [];
  }

  // Client-side filter and sort
  void filterAndSortProducts({
    String category = 'all',
    String sortOrder = 'popular',
  }) {
    List<Product> filteredProducts = _products;

    // 1. Filter by category if needed
    if (category != 'all') {
      filteredProducts = filteredProducts.where((product) {
        return product.categories.any((cat) => cat.slug == category);
      }).toList();
    }

    // 2. Sort products based on selected order
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

    // Update the products list after filtering and sorting
    _products = filteredProducts;
    notifyListeners();
  }
}
