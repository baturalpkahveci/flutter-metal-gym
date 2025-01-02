import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/models/category.dart';

class CategoryBox extends StatelessWidget {
  final Category category;

  const CategoryBox({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // Get screen width to make it responsive
    final screenWidth = MediaQuery.of(context).size.width;

    // Set the size of the box (e.g., 1/3 of the screen width)
    double boxSize = screenWidth / 3;

    return GestureDetector(
      onTap: () {
        // Handle the tap event here
        print('Category tapped: ${category.name}');
      },
      child: Container(
        width: boxSize, // Set width of the container
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15), // Rounded corners for the container
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
              offset: Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0), // Rounded corners for the image
              child: category.imageUrl.isNotEmpty
                  ? Image.network(
                category.imageUrl,
                fit: BoxFit.cover, // Image should cover the entire container area
                width: boxSize, // Set the image width to match the container width
                height: boxSize, // Set the image height to match the container height
              )
                  : const Image(
                image: AssetImage("assets/images/promotional1.jpg"),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            const SizedBox(height: 8),
            // Text Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                category.name,
                textAlign: TextAlign.center, // Center the text
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16, // Text size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
