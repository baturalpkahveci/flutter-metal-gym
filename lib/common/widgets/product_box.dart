import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';
import 'package:metal_gym_mobile_application/models/product.dart';
import 'package:metal_gym_mobile_application/pages/product_details.dart';

class ProductBox extends StatelessWidget {
  const ProductBox({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    // Calculate screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        // Handle tap event here.
        print('Product tapped!');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailsPage(product: product,),)
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffEDEDED),
          borderRadius: BorderRadius.circular(screenWidth * 0.03),

          gradient: SweepGradient(
            colors: [Color(0xffFBFBFB),Color(0xffFAFAFA), Color(0xffDDDDDD)],
            center: Alignment.topRight, // Center of the sweep
            startAngle: 0.0, // Start angle in radians
            endAngle: 3.14// End angle in radians
          )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: double.infinity,
                height: screenHeight * 0.3,
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
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                      product.name,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              Divider(
                color: AppColors.secondary,
                thickness: 0.3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${product.price} TL",
                    style: TextStyle(
                      color: AppColors.priceColor,
                      fontSize: screenWidth * 0.045,
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.12,
                    height: screenHeight * 0.04,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    child: Center(
                      child: Text(
                        '${product.averageRating}',
                        style: TextStyle(
                          color: AppColors.background,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ),
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
