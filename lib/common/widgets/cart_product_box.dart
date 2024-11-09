import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';

class CartProductBox extends StatelessWidget {
  const CartProductBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: AppColors.primary,
          width: 0
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary,
            blurRadius: 5
          )
        ]
      ),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(image: AssetImage("assets/images/promotional1.jpg")),
          SizedBox(width: 20,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                  "Product Name",
                  style: TextStyle(

                  ),
              ),
              Text(
                  "00000.00" + " TL",
                  style: TextStyle(
                    color: AppColors.priceColor,
                      fontStyle: FontStyle.italic
                  ),
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Adet: " + " 0"
              ),
              Row(
                children: [
                  IconButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                        iconSize: WidgetStatePropertyAll(15),
                      ),
                      constraints: BoxConstraints(maxHeight: 30,maxWidth: 30),
                      onPressed: null,
                      icon: Icon(
                        CupertinoIcons.minus,
                        color: AppColors.background,
                      )
                  ),
                  IconButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                        iconSize: WidgetStatePropertyAll(15),
                      ),
                      constraints: BoxConstraints(maxHeight: 30,maxWidth: 30),
                      onPressed: null,
                      icon: Icon(
                        CupertinoIcons.add,
                        color: AppColors.background,
                      )
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
