import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/services/favourite_service.dart';
import 'package:metal_gym_mobile_application/models/favourite_product.dart';

class FavoriteProvider with ChangeNotifier {
  final FavoriteService favoriteService = FavoriteService();
  List<FavoriteProduct> _favoriteProducts = [];
  bool _isLoading = false;
  String _error = '';

  List<FavoriteProduct> get favoriteProducts => _favoriteProducts;
  bool get isLoading => _isLoading;
  String get error => _error;

  // Fetch favorite products for a user
  Future<void> fetchFavoriteProducts(int userId) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _favoriteProducts = await favoriteService.getFavoriteProducts(userId);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Add a product to favorites
  Future<void> addToFavorites(int userId, int productId) async {
    await favoriteService.addToFavorites(userId, productId);
    await fetchFavoriteProducts(userId); // Reload the favorite products after adding
  }

  // Remove a product from favorites
  Future<void> removeFromFavorites(int userId, int productId) async {
    await favoriteService.removeFromFavorites(userId, productId);
    await fetchFavoriteProducts(userId); // Reload the favorite products after removing
  }
}
