import 'dart:convert';

class User {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String avatarUrl;
  final String role;
  final DateTime dateCreated;
  final DateTime dateModified;
  final Map<String, dynamic> billing;
  final Map<String, dynamic> shipping;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
    required this.role,
    required this.dateCreated,
    required this.dateModified,
    required this.billing,
    required this.shipping,
  });

  // Factory method to parse JSON response into a User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatarUrl: json['avatar_url'],
      role: json['role'],
      dateCreated: DateTime.parse(json['date_created']),
      dateModified: DateTime.parse(json['date_modified']),
      billing: json['billing'] ?? {},
      shipping: json['shipping'] ?? {},
    );
  }

  // Convert User object to JSON (for sending updates, etc.)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar_url': avatarUrl,
      'role': role,
      'date_created': dateCreated.toIso8601String(),
      'date_modified': dateModified.toIso8601String(),
      'billing': billing,
      'shipping': shipping,
    };
  }
}
