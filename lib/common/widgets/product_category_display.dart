import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';
import 'package:metal_gym_mobile_application/models/category.dart';

class ProductCategoriesDisplay extends StatelessWidget {
  final List<Category> categories; // List of categories

  const ProductCategoriesDisplay({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: categories.isNotEmpty
          ? Wrap(
        spacing: 8.0, // Horizontal space between categories
        runSpacing: 4.0, // Vertical space between categories
        children: categories.map((category) {
          return TextButton(
            onPressed: () {
              // Handle category click (e.g., filter by category)
              print('Clicked on category: ${category.name}');
              // You can navigate or perform any other action here
            },
            child: Text(
              '#${category.name}',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: MediaQuery.of(context).size.height * 0.018,
              ),
            ),
          );
        }).toList(),
      )
          : Text(
        'Kategori mevcut değil.',
        style: TextStyle(
          color: AppColors.primary,
          fontSize: MediaQuery.of(context).size.height * 0.018,
        ),
      ),
    );
  }
}
