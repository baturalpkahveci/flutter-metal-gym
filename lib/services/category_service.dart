import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metal_gym_mobile_application/models/category.dart';

class CategoryService {
  final String baseUrl = 'https://mgbackend-czhf.onrender.com';

  // Fetch categories from backend and filter out categories with specific slugs
  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));

    if (response.statusCode == 200) {
      // Parse the JSON response
      List<dynamic> data = json.decode(response.body);

      // Map the response to Category objects
      List<Category> categories = data.map((json) => Category.fromJson(json)).toList();

      // Filter out categories with the excluded slugs
      categories.removeWhere((category) =>
      category.slug == 'anasayfa-slider' || category.slug == 'genel' || category.slug == 'indirim');

      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Fetch category by ID
  Future<Category?> getCategoryById(int categoryId) async {
    final response = await http.get(Uri.parse('$baseUrl/$categoryId'));

    if (response.statusCode == 200) {
      return Category.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load category');
    }
  }
}
