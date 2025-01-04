import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/models/category.dart';
import 'package:metal_gym_mobile_application/services/category_service.dart';

class CategoryProvider with ChangeNotifier {
  final CategoryService categoryService = CategoryService();
  List<Category> _categories = [];
  Category? _category; // This will store a single category fetched by ID
  bool _isLoading = false;
  String _error = '';

  List<Category> get categories => _categories;
  Category? get category => _category; // For a single category
  bool get isLoading => _isLoading;
  String get error => _error;

  // Fetch all categories
  Future<void> fetchCategories() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _categories = await categoryService.fetchCategories();
    } catch (e) {
      _error = e.toString();
    }

    print("Categories found: ${_categories.length}");
    _isLoading = false;
    notifyListeners();
  }

  // Function to fetch category by ID
  Future<void> fetchCategoryById(int categoryId) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _category = await categoryService.getCategoryById(categoryId);
    } catch (e) {
      _error = 'Failed to fetch category: ${e.toString()}';
    }

    _isLoading = false;
    notifyListeners();
  }
}
