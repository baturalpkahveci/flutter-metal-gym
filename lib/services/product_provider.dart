

import 'dart:convert';

import '../models/product.dart';

Future<List<Product>> fetchProducts({String? searchTerm}) async {
  const String consumerKey = 'your_consumer_key';
  const String consumerSecret = 'your_consumer_secret';
  const String baseUrl = 'https://metalgymturkey.com/wp-json/wc/v3/products';

  String auth = base64Encode(utf8.encode('$consumerKey:$consumerSecret'));

  // Build the query URL
  String url = baseUrl;
  if (searchTerm != null && searchTerm.isNotEmpty) {
    url += '?search=${Uri.encodeComponent(searchTerm)}';
  }

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic $auth',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching products: $e');
  }
}
