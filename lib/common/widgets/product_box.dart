import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';
import 'package:metal_gym_mobile_application/models/product.dart';

class ProductBox extends StatelessWidget {
  const ProductBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          child: Container(
            constraints: BoxConstraints(maxHeight: 200),
            child: Expanded(child: Image(image: AssetImage("assets/images/promotional1.jpg"))),
          ),
        ),
        SizedBox(height: 4),
        Text(
            "Example_Product_Name",
            style: TextStyle(
              shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 80
                )
              ]
            ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "00000.00" + " TL",
              style: TextStyle(
                  color: AppColors.priceColor,
              ),
            ),
            IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                  iconSize: WidgetStatePropertyAll(15),
                ),
                constraints: BoxConstraints(maxHeight: 30,maxWidth: 30),
                onPressed: null,
                icon: Icon(
                  Icons.add,
                  color: AppColors.background,
                )
            )
          ],
        ),

      ],
    );
  }
}
