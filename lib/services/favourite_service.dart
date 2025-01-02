import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metal_gym_mobile_application/models/favourite_product.dart';

class FavoriteService {
  final String baseUrl;

  FavoriteService({required this.baseUrl});

  // Add a product to favorites
  Future<List<int>> addToFavorites(int userId, int productId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/favorites/$userId/$productId'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<int>.from(data['favorites']);
    } else {
      throw Exception('Failed to add product to favorites');
    }
  }

  // Remove a product from favorites
  Future<List<int>> removeFromFavorites(int userId, int productId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/favorites/$userId/$productId'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<int>.from(data['favorites']);
    } else {
      throw Exception('Failed to remove product from favorites');
    }
  }

  // Get all favorite products for a user
  Future<List<FavoriteProduct>> getFavoriteProducts(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/favorites/$userId'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['favorites'] as List)
          .map((item) => FavoriteProduct.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to fetch favorite products');
    }
  }
}
