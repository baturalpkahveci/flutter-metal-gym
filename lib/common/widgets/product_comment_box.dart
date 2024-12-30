import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';

class ProductCommentBox extends StatelessWidget {
  final String userName;
  final DateTime date;
  final String comment;

  const ProductCommentBox({
    Key? key,
    required this.userName,
    required this.date,
    required this.comment,
  })  : super(key: key);

  @override
  Widget build(BuildContext context)  {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0),
                  blurRadius: 20,
                  spreadRadius: screenWidth * 0.025,
                ),
              ],
            ),
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              userName,
                              style: TextStyle(
                                color: AppColors.primary,
                                fontFamily: 'liberation_sans',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${date.day}/${date.month}/${date.year}',
                              style: TextStyle(
                                color: AppColors.primary.withOpacity(0.6),
                                fontFamily: 'liberation_sans',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: AppColors.primary,
                  thickness: 0.2,
                ),
                Column(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: double.infinity,  // Ensures the container expands to fit text
                      ),
                      child: Text(
                        comment,
                        style: TextStyle(
                          fontFamily: 'liberation_sans',
                          fontSize: 14,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w400,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}