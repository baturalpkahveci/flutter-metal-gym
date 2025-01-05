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
      debugPrint('Current cartList: $cartList'); // Log current cart state

      for (int i = 0; i < cartList.length; i++) {
        try {
          final cartItemMap = json.decode(cartList[i]);
          final existingItem = CartItem.fromJson(cartItemMap);
          if (existingItem.product.id == item.product.id) {
            existingItem.quantity += item.quantity;
            cartList[i] = json.encode(existingItem.toJson());
            debugPrint('Updated cart item: ${cartList[i]}'); // Log updated item
            await prefs.setStringList(_cartKey, cartList);
            return;
          }
        } catch (e) {
          debugPrint('Error parsing cart item at index $i: $e');
        }
      }

      // Add new item if not found
      cartList.add(json.encode(item.toJson()));
      await prefs.setStringList(_cartKey, cartList);
      debugPrint('Added new item to cart: ${item.toJson()}'); // Log new item
    } catch (e, stackTrace) {
      debugPrint('Error in addToCart: $e\n$stackTrace');
      throw Exception('Failed to add item to cart: $e');
    }
  }




  // Get all cart items
  Future<List<CartItem>> getCartItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> cartList = prefs.getStringList(_cartKey) ?? [];
      debugPrint('Raw cartList from SharedPreferences: $cartList');

      return cartList.map((item) {
        try {
          final decodedItem = json.decode(item); // Decode JSON string
          debugPrint('Decoded cart item: $decodedItem');

          // Validate decoded item structure
          if (decodedItem is! Map<String, dynamic>) {
            throw Exception('Invalid cart item format: $decodedItem');
          }

          return CartItem.fromJson(decodedItem);
        } catch (e) {
          debugPrint('Error decoding cart item: $e');
          throw Exception('Failed to decode cart item: $e');
        }
      }).toList();
    } catch (e, stackTrace) {
      debugPrint('Error in getCartItems: $e\n$stackTrace');
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

  // Increment the quantity of a product in the cart
  Future<void> incrementQuantity(int productId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> cartList = prefs.getStringList(_cartKey) ?? [];

      for (int i = 0; i < cartList.length; i++) {
        final cartItemMap = json.decode(cartList[i]);
        final cartItem = CartItem.fromJson(cartItemMap);

        if (cartItem.product.id == productId) {
          cartItem.quantity += 1; // Increment quantity
          cartList[i] = json.encode(cartItem.toJson());
          await prefs.setStringList(_cartKey, cartList);
          return;
        }
      }

      throw Exception('Product with ID $productId not found in cart');
    } catch (e) {
      throw Exception('Failed to increment quantity: ${e.toString()}');
    }
  }

// Decrement the quantity of a product in the cart
  Future<void> decrementQuantity(int productId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> cartList = prefs.getStringList(_cartKey) ?? [];

      for (int i = 0; i < cartList.length; i++) {
        final cartItemMap = json.decode(cartList[i]);
        final cartItem = CartItem.fromJson(cartItemMap);

        if (cartItem.product.id == productId) {
          if (cartItem.quantity > 1) {
            cartItem.quantity -= 1; // Decrement quantity
            cartList[i] = json.encode(cartItem.toJson());
          } else {
            // Remove the item if quantity drops to 0
            cartList.removeAt(i);
          }

          await prefs.setStringList(_cartKey, cartList);
          return;
        }
      }

      throw Exception('Product with ID $productId not found in cart');
    } catch (e) {
      throw Exception('Failed to decrement quantity: ${e.toString()}');
    }
  }

}
