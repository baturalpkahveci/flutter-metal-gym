import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/common/widgets/cart_product_box.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';
import 'package:metal_gym_mobile_application/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Toplam tutarı hesapla
    double totalCost = cartProvider.cartItems.fold(0.0, (sum, cartItem) {
      return sum + (cartItem.product.price * cartItem.quantity);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sepetim"),
      ),
      body: Column(
        children: [
          _cartItemsSection(screenWidth, screenHeight, cartProvider),
          _totalAmountandCheckoutSection(screenWidth, screenHeight, totalCost),
        ],
      ),
    );
  }

  Container _totalAmountandCheckoutSection(double screenWidth, double screenHeight, double totalCost) {
    return Container(
      height: screenHeight * 0.15,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(screenWidth * 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: screenHeight * 0.01,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Toplam:",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.arrow_turn_up_right,
                    color: AppColors.primary,
                    size: screenWidth * 0.08,
                  ),
                  SizedBox(width: screenWidth * 0.03,),
                  Text(
                    "${totalCost.toStringAsFixed(2)} TL", // Toplam tutarı göster
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
          Container(
            height: screenHeight * 0.06,
            width: screenWidth * 0.3,
            decoration: BoxDecoration(
              color: AppColors.highlighted,
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: screenWidth * 0.01,
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Satın Al',
                style: TextStyle(
                  color: AppColors.background,
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _cartItemsSection(double screenWidth, double screenHeight, CartProvider cartProvider) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.025,
          vertical: screenWidth * 0.025,
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3.5,
            crossAxisSpacing: screenWidth * 0.01,
            mainAxisSpacing: screenWidth * 0.01,
          ),
          itemCount: cartProvider.cartItems.length,
          itemBuilder: (context, index) {
            final cartItem = cartProvider.cartItems[index];
            return CartProductBox(cartItem: cartItem);
          },
        ),
      ),
    );
  }
}
