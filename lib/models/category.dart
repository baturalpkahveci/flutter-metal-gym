class Category {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String imageUrl;
  final int productCount;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.imageUrl,
    required this.productCount,
  });

  // Factory method to parse JSON into Category
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'] ?? '',
      imageUrl: json['image'] != null ? json['image']['src'] : '',
      productCount: json['count'] ?? 0,
    );
  }

  // Convert Category to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'image': {'src': imageUrl},
      'count': productCount,
    };
  }
}
