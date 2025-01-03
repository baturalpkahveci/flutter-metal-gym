import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:metal_gym_mobile_application/models/cart_item.dart';

class CartService {
  static const String _cartKey = 'cart'; // Key for SharedPreferences

  // Add item to the cart
  Future<void> addToCart(CartItem item) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartList = prefs.getStringList(_cartKey) ?? [];

    // Check if the item already exists in the cart
    bool itemExists = false;
    for (var cartItem in cartList) {
      final cartItemMap = json.decode(cartItem);
      final existingItem = CartItem.fromJson(cartItemMap);
      if (existingItem.product.id == item.product.id) {  // Compare by product ID
        itemExists = true;
        // Update the quantity of the existing item
        existingItem.quantity += item.quantity;
        cartList[cartList.indexOf(cartItem)] = json.encode(existingItem);
        break;
      }
    }

    // If the item doesn't exist, add it to the cart list
    if (!itemExists) {
      cartList.add(json.encode(item.toJson()));
    }

    await prefs.setStringList(_cartKey, cartList); // Save to SharedPreferences
  }

  // Get all cart items
  Future<List<CartItem>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartList = prefs.getStringList(_cartKey) ?? [];

    return cartList.map((item) {
      final cartItemMap = json.decode(item);
      return CartItem.fromJson(cartItemMap);
    }).toList();
  }

  // Remove item from the cart
  Future<void> removeFromCart(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartList = prefs.getStringList(_cartKey) ?? [];

    cartList.removeWhere((item) {
      final cartItemMap = json.decode(item);
      final cartItem = CartItem.fromJson(cartItemMap);
      return cartItem.product.id == productId; // Compare by product ID
    });

    await prefs.setStringList(_cartKey, cartList); // Save to SharedPreferences
  }

  // Clear all items from the cart
  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}
