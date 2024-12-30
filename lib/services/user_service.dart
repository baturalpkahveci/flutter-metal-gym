import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metal_gym_mobile_application/models/user.dart';

class UserService {
  final String baseUrl = 'https://mgbackend-czhf.onrender.com'; // Replace with your server URL

  // Fetch user by ID
  Future<User> fetchUserById(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/customers/$userId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to fetch user: ${response.statusCode}');
    }
  }

  // Fetch all users (optional, for admin)
  Future<List<User>> fetchAllUsers({int perPage = 20, int page = 1}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/customers?per_page=$perPage&page=$page'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to fetch users: ${response.statusCode}');
    }
  }

  // Update user profile
  Future<User> updateUser(int userId, Map<String, dynamic> updatedData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/customers/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedData),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to update user: ${response.statusCode}');
    }
  }

  // Function to register a new user
  Future<User> registerUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users'),  // Adjust the endpoint according to your backend
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(user.toJson()),  // Convert the User object to JSON
      );

      if (response.statusCode == 201) {
        // User registered successfully
        return User.fromJson(json.decode(response.body)); // Convert the response to a User object
      } else {
        // If the server does not return a 201 status, throw an error
        throw Exception('Failed to register user: ${response.body}');
      }
    } catch (error) {
      // Handle network or other errors
      throw Exception('Error registering user: $error');
    }
  }

  // Login function to authenticate the user
  static Future<User?> login(String username, String password) async {
    final url = Uri.parse('http://your-backend-url.com/login'); // Replace with your backend URL

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'username': username,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        return User.fromJson(userData);  // Parse and return user object
      } else {
        throw Exception('Failed to login. Please check your credentials.');
      }
    } catch (error) {
      throw Exception('Error during login: $error');
    }
  }
}
