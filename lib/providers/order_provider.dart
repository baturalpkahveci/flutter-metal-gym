import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/models/order.dart';  // Import the Order model
import 'package:metal_gym_mobile_application/services/order_service.dart';  // Import the Order service

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fetch orders for a specific customer
  Future<void> fetchOrders(int customerId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final fetchedOrders = await OrderService().fetchAllOrdersForCustomer(customerId);
      _orders = fetchedOrders;
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = 'Error fetching orders: $error';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch a single order by ID
  Future<void> fetchOrderById(int orderId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final order = await OrderService().fetchOrderById(orderId);
      // Do something with the fetched order if needed
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = 'Error fetching order: $error';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create a new order
  Future<void> createOrder(Map<String, dynamic> orderData) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final newOrder = await OrderService().createOrder(orderData);
      _orders.add(newOrder);  // Add the newly created order to the list
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = 'Error creating order: $error';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update order status
  Future<void> updateOrderStatus(int orderId, String status) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final updatedOrder = await OrderService().updateOrderStatus(orderId, status);
      // Find the updated order in the list and update its status
      _orders = _orders.map((order) {
        return order.id == orderId ? updatedOrder : order;
      }).toList();
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = 'Error updating order status: $error';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Cancel an order
  Future<void> cancelOrder(int orderId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await OrderService().cancelOrder(orderId);
      _orders.removeWhere((order) => order.id == orderId);  // Remove the cancelled order from the list
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = 'Error canceling order: $error';
      _isLoading = false;
      notifyListeners();
    }
  }
}
