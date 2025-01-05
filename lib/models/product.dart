import 'package:flutter/cupertino.dart';
import 'package:metal_gym_mobile_application/models/category.dart';

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
  final List<Category> categories; // List of Category objects
  final String imageUrl; // Main image URL
  final List<String> gallery; // List of additional image URLs
  final int totalSales; // Total sales count
  final double averageRating; // Average product rating
  final int ratingCount; // Number of ratings
  final bool isFeatured; // Whether the product is featured
  final List<String> tags; // List of product tags
  final String permalink; // Product permalink URL
  final String dateCreated; // The date the product was created
  final String status; // The status of the product (e.g., "publish")

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
    required this.categories,
    required this.imageUrl,
    required this.gallery,
    required this.totalSales,
    required this.averageRating,
    required this.ratingCount,
    required this.isFeatured,
    required this.tags,
    required this.permalink,
    required this.dateCreated,
    required this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    debugPrint('Parsing Product from JSON: $json'); // Log the entire product JSON

    // Handle tags
    final tags = (json['tags'] as List<dynamic>?)
        ?.map((tag) {
      if (tag is Map<String, dynamic> && tag['name'] is String) {
        return tag['name'] as String; // Extract the name
      } else {
        debugPrint('Invalid tag format: $tag');
        return null; // Skip invalid entries
      }
    })
        .whereType<String>() // Filter out null values
        .toList() ?? [];

    // Handle images with validation
    final gallery = (json['images'] as List<dynamic>?)
        ?.map((image) {
      if (image is Map<String, dynamic> && image['src'] is String) {
        return "${image['src']}?width=300&height=300";
      } else {
        debugPrint('Invalid gallery image format: $image');
        return null; // Skip invalid entries
      }
    })
        .whereType<String>() // Filter out null values
        .toList() ?? [];

    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] ?? '',
      shortDescription: json['short_description'] ?? '',
      price: double.tryParse(json['regular_price']?.toString() ?? '0.0') ?? 0.0,
      salePrice: json['sale_price'] != null
          ? double.tryParse(json['sale_price']?.toString() ?? '0.0')
          : null,
      onSale: json['on_sale'] ?? false,
      sku: json['sku'] ?? '',
      stockQuantity: json['stock_quantity'] ?? 0,
      inStock: json['stock_status'] == 'instock',
      categories: (json['categories'] as List<dynamic>?)
          ?.map((category) => Category.fromJson(category))
          .toList() ??
          [],
      imageUrl: (json['images'] != null && json['images'].isNotEmpty)
          ? "${json['images'][0]['src']}?width=300&height=300"
          : '',
      gallery: gallery,
      totalSales: json['total_sales'] ?? 0,
      averageRating:
      double.tryParse(json['average_rating']?.toString() ?? '0.0') ?? 0.0,
      ratingCount: json['rating_count'] ?? 0,
      isFeatured: json['featured'] ?? false,
      tags: tags,
      permalink: json['permalink'] ?? '',
      dateCreated: json['date_created'] ?? '',
      status: json['status'] ?? 'publish',
    );
  }


  /// Convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'short_description': shortDescription,
      'regular_price': price,
      'sale_price': salePrice,
      'on_sale': onSale,
      'sku': sku,
      'stock_quantity': stockQuantity,
      'stock_status': inStock ? 'instock' : 'outofstock',
      'categories': categories.map((category) => category.toJson()).toList(),
      'image_url': imageUrl,
      'gallery': gallery,
      'total_sales': totalSales,
      'average_rating': averageRating,
      'rating_count': ratingCount,
      'is_featured': isFeatured,
      'tags': tags,
      'permalink': permalink,
      'date_created': dateCreated,
      'status': status,
    };
  }
}
