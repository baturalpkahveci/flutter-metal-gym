import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';
import 'package:metal_gym_mobile_application/pages/categories.dart';
import 'package:metal_gym_mobile_application/pages/log_in.dart';
import 'package:metal_gym_mobile_application/pages/product_details.dart';
import 'package:metal_gym_mobile_application/pages/profile.dart';
import 'package:metal_gym_mobile_application/pages/shop.dart';
import 'package:metal_gym_mobile_application/pages/shopping_cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[ //PAGES WILL BE ADDED HERE
            CategoriesPage(),
            ShopPage(),
            ShoppingCart(),
            ProfilePage(),
            //LoginScreen()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: AppColors.primary,
        animationDuration: const Duration(milliseconds: 100),
        showInactiveTitle: true,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: const Text('Kategoriler'),
            icon: const Icon(Icons.apps_outlined),
            activeColor: AppColors.background,
            inactiveColor: AppColors.secondary,
          ),
          BottomNavyBarItem(
              title: const Text('Mağaza'),
              icon: const Icon(Icons.shop_2),
              activeColor: AppColors.background,
              inactiveColor: AppColors.secondary,
          ),
          BottomNavyBarItem(
              title: const Text('Sepet'),
              icon: const Icon(Icons.shopping_basket),
              activeColor: AppColors.background,
              inactiveColor: AppColors.secondary
          ),
          BottomNavyBarItem(
              title: const Text('Profil'),
              icon: const Icon(Icons.person),
              activeColor: AppColors.background,
              inactiveColor: AppColors.secondary
          ),
        ],
      ),
    );
  }
}