import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Metal GYM',
          style: TextStyle(
            fontFamily: "Designer",
            color: AppColors.background,
            fontSize: 30,
            shadows: [Shadow(
                color: Colors.white,
                blurRadius: 10.0
            )],
          ),
        ),
        backgroundColor: AppColors.primary,
        shadowColor: Colors.black,
        elevation: 8,

      ),
      backgroundColor: AppColors.background,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          verticalDirection: VerticalDirection.down,
          children: [
            SearchBar(
              leading: Container(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 10,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownMenu(
                    width: 150,
                    hintText: "Kategori",
                    helperText: "Kategori",
                    initialSelection: "actual_data_0",
                    dropdownMenuEntries: <DropdownMenuEntry<String>>[
                      DropdownMenuEntry(value: "actual_data_0", label: "Hepsi"),
                      DropdownMenuEntry(value: "actual_data_1", label: "Category1"),
                      DropdownMenuEntry(value: "actual_data_2", label: "Category2")
                    ]
                ),
                DropdownMenu(
                    width: 150,
                    hintText: "Sırala",
                    helperText: "Sırala",
                    dropdownMenuEntries: <DropdownMenuEntry<String>>[
                      DropdownMenuEntry(value: "actual_data_0", label: "En popüler"),
                      DropdownMenuEntry(value: "actual_data_1", label: "Artan"),
                      DropdownMenuEntry(value: "actual_data_2", label: "Azalan")
                    ]
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
