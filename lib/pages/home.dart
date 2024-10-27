import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Metal GYM",
        style: TextStyle(
          fontFamily: "Designer",
          color: Colors.black,
          fontSize: 26,
          fontWeight: FontWeight.bold,
          shadows: [Shadow(
                blurRadius: 10.0,
                color: Colors.white,
                offset: Offset(0.0, 1.0),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        shadowColor: Colors.black,
        elevation: 10.0,
        leading: Container(
          margin: const EdgeInsets.all(10),
          //child: SvgPicture.asset(), //TO DO
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );
  }
}
