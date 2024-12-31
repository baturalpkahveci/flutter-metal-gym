import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';
import 'package:metal_gym_mobile_application/models/product.dart';
import 'package:metal_gym_mobile_application/pages/product_details.dart';

class ProductBox extends StatelessWidget {
  const ProductBox({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        // Handle tap event here.
        print('Product tapped!');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailsPage(product: product,),)
        );
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            child: Container(
              constraints: BoxConstraints(maxHeight: 200),
              child: Image.network(
                "${product.imageUrl}?width=100&height=100",
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
              )
            ),
          ),
          SizedBox(height: 4),
          Text(
              product.name,
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
                "${product.price} TL",
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
      ),
    );
  }
}
