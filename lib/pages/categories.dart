import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/common/widgets/category_box.dart';

import '../core/app_colors.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints.expand(
                height: 200
              ),
              decoration: const BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 30
                    )
                  ]
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
                        Shadow(
                          color: Colors.white,
                          blurRadius: 30
                        )
                      ]
                    ),
                  ),
                  Text(
                    "Fiyatlarımıza KDV dahil değildir.",
                    style: TextStyle(
                      color: AppColors.background,
                      fontSize: 12
                    ),
                  )
                ],
              ),
            ),
            Container(
              constraints: const BoxConstraints.expand(
                  height: 50
              ),
              decoration: const BoxDecoration(
                  color: AppColors.secondary,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 15
                    )
                  ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        //GO TO SALE CATEGORY
                      },
                      child: const Text(
                          "İndirimli Ürünler",
                          style: TextStyle(
                            color: AppColors.highlighted,
                            shadows: [
                              Shadow(
                                color: AppColors.primary,
                                blurRadius: 50
                              )
                            ]
                          ),
                      )
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.all(20),
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1/1,
                  shrinkWrap: true,
                  children: [ //CATEGORY BOXES
                    CategoryBox(),
                    CategoryBox(),
                    CategoryBox(),
                    CategoryBox(),
                    CategoryBox(),
                    CategoryBox(),
                    CategoryBox(),
                    CategoryBox(),
                    CategoryBox(),
                  ],
                )
            ),
          ],
        )
      )
    );
  }
}
