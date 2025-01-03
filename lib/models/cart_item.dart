import 'package:metal_gym_mobile_application/models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  // Convert CartItem to a Map (for storage)
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),  // Convert the Product object to a Map
      'quantity': quantity,
    };
  }

  // Convert a Map to CartItem
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),  // Deserialize Product
      quantity: json['quantity'],
    );
  }
}
