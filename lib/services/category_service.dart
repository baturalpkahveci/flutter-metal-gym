import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metal_gym_mobile_application/models/category.dart';

class CategoryService {
  final String baseUrl = 'https://mgbackend-czhf.onrender.com';

  // Fetch categories from backend
  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));

    if (response.statusCode == 200) {
      // Parse the JSON response
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
