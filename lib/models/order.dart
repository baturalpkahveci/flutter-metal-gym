class Order {
  final int id;
  final String status;
  final double total;
  final DateTime dateCreated;

  Order({
    required this.id,
    required this.status,
    required this.total,
    required this.dateCreated,
  });

  // Factory constructor to create an Order instance from JSON data
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      status: json['status'],
      total: double.tryParse(json['total']?.toString() ?? '0.0') ?? 0.0,
      dateCreated: DateTime.parse(json['date_created']),
    );
  }
}
