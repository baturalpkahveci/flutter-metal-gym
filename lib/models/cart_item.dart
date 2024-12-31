class CartItem {
  final int productId;
  final String name;
  final double price;
  int quantity;

  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  // Convert CartItem to a Map (for storage)
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }

  // Convert a Map to CartItem
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}
