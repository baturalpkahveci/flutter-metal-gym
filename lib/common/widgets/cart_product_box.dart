import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';
import 'package:metal_gym_mobile_application/models/cart_item.dart';
import 'package:metal_gym_mobile_application/pages/product_details.dart';
import 'package:metal_gym_mobile_application/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartProductBox extends StatelessWidget {
  const CartProductBox({super.key, required this.cartItem});
  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap:  ()  {
        // Handle the tap event here.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: cartItem.product,)
          ),
        );
        print('Cart item tapped!');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          gradient: SweepGradient(
              colors: [Color(0xffFBFBFB),Color(0xffFAFAFA), Color(0xffDDDDDD)],
              center: Alignment.topRight, // Center of the sweep
              startAngle: 0.0, // Start angle in radians
              endAngle: 3.14// End angle in radians
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025, vertical: screenHeight * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenWidth * 0.6,
                        child: Text(
                          cartItem.product.name,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: screenWidth * 0.3,
                        child: Text(
                          '${cartItem.product.price} TL',
                          style: TextStyle(
                            color: AppColors.priceColor,
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenWidth * 0.25,
                        child: Center(
                          child: Text(
                            'Adet: ${cartItem.quantity}',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle tap event here.
                          cartProvider.decrementQuantity(cartItem.product.id);
                          print('Product amount decremented to ${cartItem.quantity}');

                        },
                        child: CircleAvatar(
                          radius: screenWidth * 0.04,
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            Icons.remove,
                            color: AppColors.background,
                            size: screenWidth * 0.04,
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.025,),
                      GestureDetector(
                        onTap: () {
                          // Handle tap event here.
                          cartProvider.incrementQuantity(cartItem.product.id);
                          print('Product amount incremented to ${cartItem.quantity}');
                        },
                        child: CircleAvatar(
                          radius: screenWidth * 0.04,
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            Icons.add,
                            color: AppColors.background,
                            size: screenWidth * 0.04,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
