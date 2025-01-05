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

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] ?? '',
      imageUrl: json['image']?['src'] ?? '',
      productCount: json['count'] ?? 0,
    );
  }

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
