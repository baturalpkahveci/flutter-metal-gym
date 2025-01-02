import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/models/category.dart';
import 'package:metal_gym_mobile_application/services/category_service.dart';

class CategoryProvider with ChangeNotifier {
  final CategoryService categoryService = CategoryService();
  List<Category> _categories = [];
  bool _isLoading = false;
  String _error = '';

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String get error => _error;
  
  // Fetch categories
  Future<void> fetchCategories() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _categories = await categoryService.fetchCategories();
    } catch (e) {
      _error = e.toString();
    }

    print("Categories found: ${categories.length}");
    _isLoading = false;
    notifyListeners();
  }
}
