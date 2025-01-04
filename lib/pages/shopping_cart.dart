import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/common/widgets/cart_product_box.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';
import 'package:metal_gym_mobile_application/models/product.dart';
import 'package:metal_gym_mobile_application/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Sepetim"),
      ),

      body: Container(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
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
                    return CartProductBox(cartItem: cartItem,);
                  },
                ),
              ),
            ),
            SizedBox(),
            Container(
              color: AppColors.background,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          "Toplam:",
                          style: TextStyle(
                            fontSize: 16
                          ),
                      ),
                      Row(
                        children: [
                          Icon(CupertinoIcons.arrow_turn_up_right, color: AppColors.primary,),
                          Text(
                              "00000.00" + " TL",
                              style: TextStyle(
                                fontSize: 28
                              ),
                          )
                        ],
                      )
                    ],
                  ),
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                      ),
                      onPressed: null,
                      child: Text(
                          "Satın Al",
                          style: TextStyle(
                            color: AppColors.background,
                            fontSize: 20
                          ),
                      )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
