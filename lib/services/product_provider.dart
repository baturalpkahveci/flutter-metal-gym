import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/models/product.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum OrderType {
  alphabeticalAsc,
  alphabeticalDesc,
  mostSold,
  averageRating,
  newest,
  oldest,
  priceAsc,
  priceDesc,
}

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts({String? searchTerm , String? category , OrderType orderType = OrderType.alphabeticalAsc}) async {
    String consumerKey = dotenv.env['CLIENT_KEY'] ?? "Key not found!";
    String consumerSecret = dotenv.env['CLIENT_SECRET'] ?? "Key not found!";
    String baseUrl = dotenv.env['BASE_URL'] ?? "Base url not found!";

    String auth = base64Encode(utf8.encode('$consumerKey:$consumerSecret'));

    int currentPage = 1;
    bool hasMorePages = true;

    // Build the query URL
    String url = baseUrl;
    if (searchTerm != null && searchTerm.isNotEmpty) {
      url += '/products?search=${Uri.encodeComponent(searchTerm)}';

      if (category != null && category.isNotEmpty){
        url += '?category=${Uri.encodeComponent(category)}';
      }

      String getOrderQueryParam(OrderType orderType) {
        switch (orderType) {
          case OrderType.alphabeticalAsc:
            return 'orderby=title&order=asc';
          case OrderType.alphabeticalDesc:
            return 'orderby=title&order=desc';
          case OrderType.mostSold:
            return 'orderby=meta_value_num&meta_key=_total_sales&order=desc';
          case OrderType.averageRating:
            return 'orderby=rating&order=desc';
          case OrderType.newest:
            return 'orderby=date&order=desc';
          case OrderType.oldest:
            return 'orderby=date&order=asc';
          case OrderType.priceAsc:
            return 'orderby=price&order=asc';
          case OrderType.priceDesc:
            return 'orderby=price&order=desc';
        }
      }
      //Order query params added
      url += '?${getOrderQueryParam(orderType)}';
      print("SEARCH URL: $url");
    }else{
      url += "/products?all=true";
    }

    try {
      _isLoading = true;
      notifyListeners();

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Basic $auth',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        print("Fetched products: $jsonData"); // Debugging
        _products = jsonData.map((product) => Product.fromJson(product)).toList();
        print("Product List: ");
        _products.forEach((element) => print(element.name),);
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }

  }

  Future<void> searchProducts(String query) async {
    await fetchProducts(searchTerm: query);
  }

  void clearSearch() {
    _searchQuery = '';
    fetchProducts();
  }
}
