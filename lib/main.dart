import 'package:flutter/material.dart';

import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          fontSizeFactor: 1.1,
          fontSizeDelta: 2.0,
        ),
        fontFamily: "Roboto",
      ),
      home: const HomePage(),
    );
  }
}
