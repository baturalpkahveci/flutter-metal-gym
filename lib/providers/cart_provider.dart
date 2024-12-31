import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/services/cart_service.dart';
import 'package:metal_gym_mobile_application/models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final CartService _cartService = CartService();
  List<CartItem> _cartItems = [];
  bool _isLoading = false;

  List<CartItem> get cartItems => _cartItems;
  bool get isLoading => _isLoading;

  // Load cart items from local storage
  Future<void> loadCartItems() async {
    _isLoading = true;
    notifyListeners();
    _cartItems = await _cartService.getCartItems();
    _isLoading = false;
    notifyListeners();
  }

  // Add an item to the cart
  Future<void> addToCart(CartItem item) async {
    await _cartService.addToCart(item);
    await loadCartItems(); // Reload the cart after adding an item
  }

  // Remove an item from the cart
  Future<void> removeFromCart(int productId) async {
    await _cartService.removeFromCart(productId);
    await loadCartItems(); // Reload the cart after removing an item
  }

  // Clear all items in the cart
  Future<void> clearCart() async {
    await _cartService.clearCart();
    _cartItems.clear(); // Clear the cart list in the provider
    notifyListeners();
  }
}
