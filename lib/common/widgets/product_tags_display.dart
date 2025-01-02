import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart'; // Assuming this is your color class

class ProductTagsDisplay extends StatelessWidget {
  final List<String> tags; // List of tags

  const ProductTagsDisplay({Key? key, required this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: tags.isNotEmpty
          ? Wrap(
        spacing: 8.0, // Horizontal space between tags
        runSpacing: 4.0, // Vertical space between tags
        children: tags.map((tag) {
          return TextButton(
            onPressed: () {
              // Handle the tag click (e.g., filter by tag)
              print('Clicked on tag: $tag');
              // You can navigate or perform any other action here
            },
            child: Text(
              '#$tag',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: MediaQuery.of(context).size.height * 0.018,
              ),
            ),
          );
        }).toList(),
      )
          : Text(
        'Etiket mevcut değil.',
        style: TextStyle(
          color: AppColors.primary,
          fontSize: MediaQuery.of(context).size.height * 0.018,
        ),
      ),
    );
  }
}
