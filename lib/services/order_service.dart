import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metal_gym_mobile_application/models/order.dart'; // Import your order model

class OrderService {
  final String apiUrl = 'https://mgbackend-czhf.onrender.com';

  // Fetch all orders for a specific customer
  Future<List<Order>> fetchAllOrdersForCustomer(int customerId) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/wp-json/wc/v3/orders/customer/$customerId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer your-jwt-token', // If using JWT for authentication
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((orderJson) => Order.fromJson(orderJson)).toList();
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (error) {
      throw Exception('Error fetching orders: $error');
    }
  }

  // Fetch a single order by ID
  Future<Order> fetchOrderById(int orderId) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/wp-json/wc/v3/orders/$orderId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer your-jwt-token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Order.fromJson(data);
      } else {
        throw Exception('Failed to load order');
      }
    } catch (error) {
      throw Exception('Error fetching order: $error');
    }
  }

  // Create a new order
  Future<Order> createOrder(Map<String, dynamic> orderData) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/wp-json/wc/v3/orders'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer your-jwt-token',
        },
        body: json.encode(orderData),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return Order.fromJson(data);
      } else {
        throw Exception('Failed to create order');
      }
    } catch (error) {
      throw Exception('Error creating order: $error');
    }
  }

  // Update order status
  Future<Order> updateOrderStatus(int orderId, String status) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/wp-json/wc/v3/orders/$orderId/status'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer your-jwt-token',
        },
        body: json.encode({
          'status': status,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Order.fromJson(data);
      } else {
        throw Exception('Failed to update order status');
      }
    } catch (error) {
      throw Exception('Error updating order status: $error');
    }
  }

  // Cancel an order
  Future<void> cancelOrder(int orderId) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/wp-json/wc/v3/orders/$orderId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer your-jwt-token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to cancel order');
      }
    } catch (error) {
      throw Exception('Error cancelling order: $error');
    }
  }
}
