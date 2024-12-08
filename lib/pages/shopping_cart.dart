import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/common/widgets/cart_product_box.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CartProductBox(),
                    CartProductBox(),
                    CartProductBox(),
                    CartProductBox(),
                    CartProductBox(),
                    CartProductBox(),
                    CartProductBox(),
                    CartProductBox(),
                    CartProductBox(),
                    CartProductBox(),
                  ],
                )
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
