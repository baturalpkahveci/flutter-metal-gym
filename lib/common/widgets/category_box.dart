import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/models/category.dart';

class CategoryBox extends StatelessWidget {
  final Category category;

  const CategoryBox({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle the tap event here
        print('Category tapped: ${category.name}');
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: category.imageUrl.isNotEmpty
                ? Image.network(category.imageUrl, fit: BoxFit.cover)
                : const Image(image: AssetImage("assets/images/promotional1.jpg"), fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Text(
            category.name,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
