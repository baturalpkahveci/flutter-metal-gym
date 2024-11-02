import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/common/widgets/custom_nav_bar.dart';
import 'package:metal_gym_mobile_application/pages/shop.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var _selectedIndex = 0;
  var pages = [ShopPage(),null,null];

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex], // MAIN SCREEN
      bottomNavigationBar: CustomNavBar( //BOTTOM NAVIGATION BAR
        currentIndex: _selectedIndex,
        onTap: _onNavBarTap,
      ),
    );
  }
}