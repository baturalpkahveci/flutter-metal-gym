import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/common/widgets/image_panel.dart';
import 'package:metal_gym_mobile_application/common/widgets/product_category_display.dart';
import 'package:metal_gym_mobile_application/common/widgets/product_tags_display.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';
import 'package:metal_gym_mobile_application/common/widgets/product_comment_box.dart';
import 'package:metal_gym_mobile_application/models/cart_item.dart';
import 'package:metal_gym_mobile_application/models/product.dart';
import 'package:metal_gym_mobile_application/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>  {
  final String exampleInfo =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';
  final String exampleComment =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';

  int productAmount = 1;


  @override
  Widget build(BuildContext context)  {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    var cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              _productImage(screenWidth, screenHeight),
              _addToFavoritesButton(screenWidth, screenHeight),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _productName(screenWidth, screenHeight),
                    _productPrice(screenWidth, screenHeight),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _productAmount(screenWidth, screenHeight),
                    _addShoppingListButton(screenWidth, screenHeight, cartProvider),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03,),
                Column(
                  children: [
                    _productInfoHeader(screenWidth, screenHeight),
                    _productInfo(screenWidth, screenHeight),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01,),
                Column(
                  children: [
                    _productCategoriesHeader(screenWidth, screenHeight),
                    _productCategories(screenWidth, screenHeight),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01,),
                Column(
                  children: [
                    _productTagsHeader(screenWidth, screenHeight),
                    _productTags(screenWidth, screenHeight),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01,),
                Column(
                  children: [
                    _productCommentsHeader(screenHeight, screenWidth),
                    _productCommentsInputField(screenHeight, screenWidth),
                    _productCommentsList(screenWidth, screenHeight),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _productCommentsList(double screenWidth, double screenHeight) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(screenWidth * 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: screenWidth * 0.025,
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ProductCommentBox(
            userName: 'User $index',
            date: DateTime.now(),
            comment: exampleComment,
          );
        },
      ),
    );
  }

  Container _productCommentsInputField(double screenHeight, double screenWidth) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: screenWidth * 0.025,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.02,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Derecelendirmeniz:",
                  style: TextStyle(
                    color: AppColors.primary.withOpacity(0.5),
                    fontSize: screenHeight * 0.018,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                RatingBar(
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  onRatingChanged: (value) {
                    print("Rating changed to $value");
                  },
                  isHalfAllowed: false,
                  filledColor: AppColors.highlighted,
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.01,),
          TextField(
            maxLines: 5,
            minLines: 1,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.background,
              contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.05),
              hintText: 'Yorum yap...',
              hintStyle: TextStyle(
                color: AppColors.primary.withOpacity(0.5),
                fontSize: screenHeight * 0.018,
                fontWeight: FontWeight.w500,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.zero),
                borderSide: BorderSide.none,
              ),
              suffixIcon: Icon(
                Icons.arrow_circle_right_outlined,
                color: AppColors.primary.withOpacity(0.5),
                size: screenWidth * 0.08,
              ),
            ),
            style: TextStyle(
              color: AppColors.primary,
              fontSize: screenHeight * 0.018,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      )
    );
  }


  Container _productCommentsHeader(double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.07,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(screenWidth * 0.05),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.05),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Ürün Yorumları ve Puanları',
              style: TextStyle(
                color: AppColors.background,
                fontSize: screenHeight * 0.021,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Container _productInfoHeader(double screenWidth, double screenHeight) {
    return Container(
      height: screenHeight * 0.07,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(screenWidth * 0.05),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.05),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Ürün Açıklaması',
              style: TextStyle(
                color: AppColors.background,
                fontSize: screenHeight * 0.021,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _productTags(double screenWidth, double screenHeight) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(screenWidth * 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: screenWidth * 0.025,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ProductTagsDisplay(tags: widget.product.tags),
          ],
        ),
      ),
    );
  }

  Container _productTagsHeader(double screenWidth, double screenHeight) {
    return Container(
      height: screenHeight * 0.07,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(screenWidth * 0.05),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.05),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Ürün Etiketleri',
              style: TextStyle(
                color: AppColors.background,
                fontSize: screenHeight * 0.021,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _productInfo(double screenWidth, double screenHeight) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(screenWidth * 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: screenWidth * 0.025,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: screenWidth * 0.8,
              child: Text(
                (widget.product.description)  == '' ? "Ürün açıklaması bulunmamaktadır." : widget.product.description.substring(3, (widget.product.description).length - 5),
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: screenHeight * 0.018,
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _productCategoriesHeader(double screenWidth, double screenHeight) {
    return Container(
      height: screenHeight * 0.07,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(screenWidth * 0.05),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.05),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Ürün Kategorileri',
              style: TextStyle(
                color: AppColors.background,
                fontSize: screenHeight * 0.021,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _productCategories(double screenWidth, double screenHeight) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(screenWidth * 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: screenWidth * 0.025,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ProductCategoriesDisplay(categories: widget.product.categories)
          ],
        ),
      ),
    );
  }

  GestureDetector _addShoppingListButton(double screenWidth, double screenHeight, CartProvider cartProvider) {
    return GestureDetector(
      onTap: () {
        // Handle tap event here.
        if (productAmount > 0) {
          cartProvider.addToCart(CartItem(product: widget.product , quantity: productAmount));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '$productAmount adet ${widget.product.name} sepetinize eklendi',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: screenWidth * 0.04,
                ),
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Color(0xffFBFBFB),
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(screenWidth * 0.05),
                  )
              ),
              action: SnackBarAction(
                textColor: AppColors.highlighted,
                label: 'Geri Al',
                onPressed: () {
                  // Handle the "UNDO" action
                  cartProvider.removeFromCart(widget.product.id);
                  print('Undo action performed');
                },
              ),
            ),
          );
          print("$productAmount products added to cart.");
        }
      },
      child: Container(
        height: screenHeight * 0.07,
        width: screenWidth * 0.35,
        decoration: BoxDecoration(
          color: AppColors.highlighted,
          borderRadius: BorderRadius.circular(screenWidth * 0.025),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: screenWidth * 0.025,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.shopping_basket_outlined,
              size: screenWidth * 0.05,
            ),
            Text(
              'Sepete Ekle',
              style: TextStyle(
                color: AppColors.background,
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _productAmount(double screenWidth, double screenHeight) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                // Handle tap event here.
                setState(() {
                  if (productAmount > 1) productAmount--;
                });
                print('Product amount decremented.');
              },
              child: CircleAvatar(
                radius: screenWidth * 0.05,
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.remove,
                  color: AppColors.background,
                  size: screenWidth * 0.06,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.025,),
            Container(
              height: screenHeight * 0.05,
              width: screenWidth * 0.2,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                productAmount.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: screenWidth * 0.05,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.025,),
            GestureDetector(
              onTap: () {
                // Handle tap event here.
                setState(() {
                  productAmount++;
                });
                print('Product amount incremented.');
              },
              child: CircleAvatar(
                radius: screenWidth * 0.05,
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.add,
                  color: AppColors.background,
                  size: screenWidth * 0.06,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Text _productPrice(double screenWidth, double screenHeight) {
    return Text(
      '${widget.product.price} TL',
      style: TextStyle(
        color: AppColors.priceColor,
        fontSize: screenWidth * 0.045,
      ),
    );
  }

  Container _productName(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.product.name,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
            ),
            softWrap: true,
          ),
        ],
      ),
    );
  }

  Positioned _addToFavoritesButton(double screenWidth, double screenHeight) {
    return Positioned(
      top: screenHeight * (0.5 - 0.07),
      left: screenWidth * (1 - 0.4),
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${widget.product.name} favorilerinize eklendi',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: screenWidth * 0.04,
                ),
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Color(0xffFBFBFB),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(screenWidth * 0.05),
                ),
              ),
              action: SnackBarAction(
                textColor: AppColors.highlighted,
                label: 'Geri Al',
                onPressed: () {
                  // Handle the "UNDO" action
                  print('Undo action performed');
                },
              ),
            ),
          );
          print('Add to favorites button tapped.');
        },
        child: Container(
          width: screenWidth * 0.4,
          height: screenHeight * 0.07,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(screenWidth * 0.05),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(-screenWidth * 0.0125, -screenWidth * 0.0125),
                blurRadius: 5,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.add_circle_rounded,
                  color: AppColors.secondary,
                  size: screenWidth * 0.04,
                ),
                Text(
                  'Favorilere Ekle',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _productImage(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth,
      height: screenHeight * 0.55,
      color: AppColors.background,
      child: ImagePanel(
        imageUrls: widget.product.gallery,
        dotColor: AppColors.primary,
        activeDotColor: AppColors.highlighted,
        height: screenHeight * 0.5,
      ),
    );
  }
}