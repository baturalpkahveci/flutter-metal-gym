import 'package:flutter/material.dart';

class CategoryBox extends StatelessWidget {
  const CategoryBox({super.key, this.image = const Image(image: AssetImage("assets/images/promotional1.jpg")), this.text = "sample_text"});

  final image;
  final text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle the tap event here
        print('GestureDetector tapped!');
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: image,
          ),
          const SizedBox(height: 8),
          Text(text,style: const TextStyle(color: Colors.black),),
        ],
      ),
    );
  }
}
