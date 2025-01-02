import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/common/widgets/category_box.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';
import 'package:metal_gym_mobile_application/providers/category_provider.dart'; // Assuming you have a CategoryProvider
import 'package:provider/provider.dart';
import 'package:metal_gym_mobile_application/models/category.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  void initState() {
    super.initState();
    // Fetch categories when the page is first loaded
    final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    categoryProvider.fetchCategories(); // Assuming fetchCategories is defined in your provider
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              constraints: const BoxConstraints.expand(height: 200),
              decoration: const BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(color: Colors.black, blurRadius: 30)
                ],
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "MetalGYM",
                    style: TextStyle(
                      color: AppColors.background,
                      fontFamily: "Designer",
                      fontSize: 36,
                      shadows: [
                        Shadow(color: Colors.white, blurRadius: 30)
                      ],
                    ),
                  ),
                  Text(
                    "Fiyatlarımıza KDV dahil değildir.",
                    style: TextStyle(
                      color: AppColors.background,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            // Sales Button Section
            Container(
              constraints: const BoxConstraints.expand(height: 50),
              decoration: const BoxDecoration(
                color: AppColors.highlighted,
                boxShadow: [
                  BoxShadow(color: Colors.black, blurRadius: 15)
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // Implement the action for sale categories
                    },
                    child: const Text(
                      "İndirimli Ürünler",
                      style: TextStyle(
                        color: AppColors.background,
                        shadows: [
                          Shadow(color: AppColors.background, blurRadius: 5),
                          Shadow(color: AppColors.background, blurRadius: 5)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Categories Grid
            Padding(
              padding: EdgeInsets.all(20),
              child: Consumer<CategoryProvider>(
                builder: (context, categoryProvider, child) {
                  if (categoryProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (categoryProvider.categories.isEmpty) {
                    return const Center(child: Text("No categories available"));
                  } else {
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Adjust for 3 columns
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1 / 1,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(), // Prevent scrolling for parent widget
                        itemCount: categoryProvider.categories.length,
                        itemBuilder: (context, index) {
                          final category = categoryProvider.categories[index];
                          return CategoryBox(
                            category: category,
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
