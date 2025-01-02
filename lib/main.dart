import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';
import 'package:metal_gym_mobile_application/providers/category_provider.dart';
import 'package:metal_gym_mobile_application/providers/favourite_provider.dart';
import 'package:metal_gym_mobile_application/providers/order_provider.dart';
import 'package:metal_gym_mobile_application/providers/product_provider.dart';
import 'package:metal_gym_mobile_application/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'pages/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
  await dotenv.load(fileName: ".env"); // Load the .env file
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //PROVIDERS
        MultiProvider(providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => ProductProvider()),
          ChangeNotifierProvider(create: (_) => FavoriteProvider()),
          ChangeNotifierProvider(create: (_) => OrderProvider()),
          ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ])
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            //GLOBAL THEME - ADD THE GENERAL THEMES
            //Only add most general themes here, if you want to change
            //a little specific detail about a widget, you can do it
            //in their respective theme part (not here)
            brightness: Brightness.dark,
            primaryColor: AppColors.primary,
            scaffoldBackgroundColor: AppColors.background,
            fontFamily: "Roboto",
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: AppColors.primary,
              selectedItemColor: AppColors.background,
              enableFeedback: true,
            ),
            textTheme: const TextTheme(
                bodyMedium: TextStyle(
                    color: Colors.black
                )
            ),
            searchBarTheme: const SearchBarThemeData(
              backgroundColor: WidgetStatePropertyAll(AppColors.secondary),
            ),
            dropdownMenuTheme: const DropdownMenuThemeData(
              menuStyle: MenuStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
              ),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                constraints: BoxConstraints(
                    minHeight: 40,
                    maxHeight: 65
                ),
              ),
              textStyle: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 14
              ),
            ),
            appBarTheme: AppBarTheme(
              shadowColor: Colors.black,
              iconTheme: IconThemeData(
                color: AppColors.background
              ),
              color: AppColors.primary,
              titleTextStyle: TextStyle(
                fontFamily: "Designer",
                color: AppColors.background,
                fontSize: 30,
                shadows: [Shadow(
                    color: Colors.white,
                    blurRadius: 10.0
                )],
              ),
            ),
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: AppColors.highlighted,
            circularTrackColor: AppColors.secondary
          )
        ),
        home: const HomePage()
      ),
    );
  }
}