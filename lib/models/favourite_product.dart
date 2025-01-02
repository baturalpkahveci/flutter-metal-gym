import 'package:metal_gym_mobile_application/models/product.dart';

class FavoriteProduct {
  final Product product;  // Use Product model inside FavoriteProduct
  final String dateAdded;  // Track when the product was added to favorites

  FavoriteProduct({
    required this.product,
    required this.dateAdded,
  });

  // Convert JSON data to a FavoriteProduct object
  factory FavoriteProduct.fromJson(Map<String, dynamic> json) {
    return FavoriteProduct(
      product: Product.fromJson(json['product']),  // Map the product data
      dateAdded: json['date_added'] ?? '',
    );
  }

  // Convert FavoriteProduct object to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),  // Convert Product to JSON
      'date_added': dateAdded,
    };
  }
}
