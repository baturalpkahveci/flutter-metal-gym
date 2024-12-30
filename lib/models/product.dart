import 'dart:ui';

class Product {
  final int id; // Product ID
  final String name; // Product name
  final String description; // Full product description
  final String shortDescription; // Short description or summary
  final double price; // Regular price
  final double? salePrice; // Sale price (optional)
  final bool onSale; // Whether the product is on sale
  final String sku; // Stock Keeping Unit (SKU)
  final int stockQuantity; // Quantity in stock
  final bool inStock; // Whether the product is in stock
  final String category; // Category name
  final String imageUrl; // Main image URL
  final List<String> gallery; // List of additional image URLs
  final int totalSales; // Total sales count
  final double averageRating; // Average product rating
  final int ratingCount; // Number of ratings
  final bool isFeatured; // Whether the product is featured
  final List<String> tags; // List of product tags

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.price,
    this.salePrice,
    required this.onSale,
    required this.sku,
    required this.stockQuantity,
    required this.inStock,
    required this.category,
    required this.imageUrl,
    required this.gallery,
    required this.totalSales,
    required this.averageRating,
    required this.ratingCount,
    required this.isFeatured,
    required this.tags,
  });

  // Factory method to parse JSON from API response
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      shortDescription: json['short_description'] ?? '',
      price: double.tryParse(json['regular_price']?.toString() ?? '0.0') ?? 0.0,
      salePrice: json['sale_price'] != null
          ? double.tryParse(json['sale_price']?.toString() ?? '0.0')
          : null,
      onSale: json['on_sale'] ?? false,
      sku: json['sku'] ?? '',
      stockQuantity: json['stock_quantity'] ?? 0,
      inStock: json['in_stock'] ?? false,
      category: (json['categories'] != null && json['categories'].isNotEmpty)
          ? json['categories'][0]['name']
          : 'Uncategorized',
      imageUrl: (json['images'] != null && json['images'].isNotEmpty)
          ? "${json['images'][0]['src']}?width=300&height=300"
          : '',
      gallery: json['images'] != null
          ? json['images']
          .map<String>((image) => "${image['src']}?width=300&height=300")
          .toList()
          : [],
      totalSales: json['total_sales'] ?? 0,
      averageRating: double.tryParse(
          json['average_rating']?.toString() ?? '0.0') ?? 0.0,
      ratingCount: json['rating_count'] ?? 0,
      isFeatured: json['featured'] ?? false,
      tags: json['tags'] != null
          ? json['tags'].map<String>((tag) => tag['name'].toString()).toList()
          : [],
    );
  }
}