import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:metal_gym_mobile_application/models/cart_item.dart';

class CartService {
  static const String _cartKey = 'cart'; // Key for SharedPreferences

  // Add item to the cart
  Future<void> addToCart(CartItem item) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> cartList = prefs.getStringList(_cartKey) ?? [];

      bool itemExists = false;

      // Debug: Print the current cart list
      debugPrint('Current cartList: $cartList');

      // Iterate through the cartList and check for an existing item
      for (int i = 0; i < cartList.length; i++) {
        final cartItemMap = json.decode(cartList[i]);

        if (cartItemMap is! Map<String, dynamic>) {
          throw Exception('Invalid cart item format: $cartItemMap');
        }

        final existingItem = CartItem.fromJson(cartItemMap);

        if (existingItem.product.id == item.product.id) {
          // Update the quantity of the existing item
          itemExists = true;
          debugPrint('Item exists. Updating quantity.');
          existingItem.quantity += item.quantity;

          // Safely update the item in the list
          cartList[i] = json.encode(existingItem.toJson());
          debugPrint('Updated item at index $i: ${cartList[i]}');
          break;
        }
      }

      // If the item doesn't exist, add it to the cart list
      if (!itemExists) {
        debugPrint('Item does not exist. Adding new item.');
        cartList.add(json.encode(item.toJson()));
        debugPrint('Added new item: ${cartList.last}');
      }

      // Save the updated cart list to SharedPreferences
      await prefs.setStringList(_cartKey, cartList);
      debugPrint('Cart updated successfully: $cartList');
    } catch (e, stackTrace) {
      debugPrint('Error in addToCart: $e\n$stackTrace');
      throw Exception('Failed to add item to cart: ${e.toString()}');
    }
  }



  // Get all cart items
  Future<List<CartItem>> getCartItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> cartList = prefs.getStringList(_cartKey) ?? [];
      debugPrint('Cart data from SharedPreferences: $cartList'); // Debug log

      return cartList.map((item) {
        final decodedItem = json.decode(item);
        if (decodedItem is! Map<String, dynamic>) {
          throw Exception('Invalid item format: $decodedItem');
        }
        return CartItem.fromJson(decodedItem);
      }).toList();
    } catch (e, stackTrace) {
      debugPrint('Error in getCartItems: $e\n$stackTrace'); // Detailed debug log
      throw Exception('Failed to retrieve cart items: ${e.toString()}');
    }
  }


  // Remove item from the cart
  Future<void> removeFromCart(int productId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> cartList = prefs.getStringList(_cartKey) ?? [];

      final initialLength = cartList.length;
      cartList.removeWhere((item) {
        final cartItemMap = json.decode(item);
        final cartItem = CartItem.fromJson(cartItemMap);
        return cartItem.product.id == productId; // Compare by product ID
      });

      if (cartList.length == initialLength) {
        throw Exception('Item with product ID $productId not found in cart');
      }

      await prefs.setStringList(_cartKey, cartList); // Save to SharedPreferences
    } catch (e) {
      throw Exception('Failed to remove item from cart: ${e.toString()}');
    }
  }

  // Clear all items from the cart
  Future<void> clearCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cartKey);
    } catch (e) {
      throw Exception('Failed to clear the cart: ${e.toString()}');
    }
  }
}
