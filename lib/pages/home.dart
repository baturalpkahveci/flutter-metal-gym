import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  final headerShadowRadius = 40.0;
  final listShadowRadius = 10.0;
  final listTextColor = Colors.white;

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


        // leading: Container(
        //   margin: const EdgeInsets.all(10),
        //   child ,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(10)
        //   ),
        // ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black87,
        shadowColor: Colors.black87,
        elevation: 100,
        child: ListView(
          children:  [
            DrawerHeader(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.black,Colors.black12],begin: Alignment(0, 0), end: Alignment(0, 4)),
                  image: DecorationImage(image: AssetImage("assets/images/promotional1.jpg"),fit: BoxFit.fitWidth,opacity: 0.7),
              ),
              child: Text(
                  'Metal GYM',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    shadows: [Shadow(
                      color: Colors.white,
                      blurRadius: headerShadowRadius
                    )],
                  ),
              )
            ),
            ListTile(
              leading: Icon(
                Icons.shop_2,
                color: Colors.white,
                shadows: [Shadow(
                  color: Colors.white,
                  blurRadius: listShadowRadius
                )],
              ),
              title: Text('Mağaza',
                style: TextStyle(
                    color: listTextColor
                ),),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.shopping_basket,
                color: Colors.white,
                shadows: [Shadow(
                    color: Colors.white,
                    blurRadius: listShadowRadius
                )],
              ),
              title: Text('Sepetim',
                style: TextStyle(
                    color: listTextColor
                ),),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.person,
                color: Colors.white,
                shadows: [Shadow(
                    color: Colors.white,
                    blurRadius: listShadowRadius
                )],
              ),
              title: Text('Profil',
                style: TextStyle(
                    color: listTextColor
                ),
              ),
              onTap: null,
            ),
          ],
        ),
      ),
    );
  }
}


