import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/models/user.dart';
import 'package:metal_gym_mobile_application/services/user_service.dart';

class UserProvider with ChangeNotifier {
  final userService = UserService();

  User? _currentUser;
  List<User> _users = [];
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  List<User> get users => _users;
  bool get isLoading => _isLoading;

  // Fetch a user by ID
  Future<void> fetchUserById(int userId) async {
    try {
      _isLoading = true;
      notifyListeners();

      _currentUser = await userService.fetchUserById(userId);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to fetch user: $e');
    }
  }

  // Fetch all users (admin functionality)
  Future<void> fetchAllUsers({int perPage = 20, int page = 1}) async {
    try {
      _isLoading = true;
      notifyListeners();

      _users = await userService.fetchAllUsers(perPage: perPage, page: page);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to fetch users: $e');
    }
  }

  // Update user profile
  Future<void> updateUser(int userId, Map<String, dynamic> updatedData) async {
    try {
      _isLoading = true;
      notifyListeners();

      _currentUser = await userService.updateUser(userId, updatedData);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to update user: $e');
    }
  }

  // Function to register a user
  Future<void> registerUser(User user) async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentUser = await userService.registerUser(user); // Call the UserService to register
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to register user: $e');
    }
  }

  // Login function to call the UserService login method
  Future<User?> login(String username, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      final user = await UserService.login(username, password); // Call login API

      if (user != null) {
        _currentUser = user;  // Save user data to memory
        _isLoading = false;
        notifyListeners();
      }
      return user;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to login: $error');
    }
  }

  // Store user data after successful login
  void setUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  // Clear user data (on logout)
  void clearUser() {
    _currentUser = null;
    notifyListeners();
  }
}
