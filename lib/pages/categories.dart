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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: Consumer<CategoryProvider>(
          builder: (context, categoryProvider, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Header Section
                  Container(
                    height: screenHeight * 0.25,
                    width: screenWidth,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "MetalGYM",
                          style: TextStyle(
                            color: AppColors.background,
                            fontFamily: "Designer",
                            fontSize: screenWidth * 0.1,
                            shadows: [
                              Shadow(color: Colors.white, blurRadius: 30)
                            ],
                          ),
                        ),
                        Text(
                          "Fiyatlarımıza KDV dahil değildir.",
                          style: TextStyle(
                            color: AppColors.background,
                            fontSize: screenWidth * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Sales Button Section
                  Container(
                    height: screenHeight * 0.08,
                    width: screenWidth,
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
                          child: Text(
                            "İndirimli Ürünler",
                            style: TextStyle(
                              color: AppColors.background,
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: AppColors.primary.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: Offset(5, 5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Main Content Section
                  categoryProvider.isLoading
                      ? SizedBox(
                    height: screenHeight - 250, // Adjust height dynamically
                    child: const Center(child: CircularProgressIndicator()),
                  )
                      : categoryProvider.categories.isEmpty
                      ? SizedBox(
                    height: screenHeight - 250,
                    child: const Center(
                      child: Text(
                        "No categories available",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                      : Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: screenWidth * 0.01,
                        crossAxisSpacing: screenWidth * 0.01,
                        childAspectRatio: 0.65,
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
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
