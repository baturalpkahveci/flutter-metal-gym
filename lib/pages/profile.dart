import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profil"),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  child: Center(
                    child: Text("METALGYM"),
                  ),
                decoration: BoxDecoration(color: AppColors.primary),
              ),
              ListTile(
                leading: Icon(CupertinoIcons.device_phone_portrait),
                title: Text("Pano"),
                onTap: () {

                },
                selectedColor: AppColors.highlighted,
                selected: true,
              ),
              ListTile(
                leading: Icon(Icons.shopping_basket_outlined),
                title: Text("Siparişler"),
              ),
              ListTile(
                leading: Icon(CupertinoIcons.arrow_down_doc),
                title: Text("İndirmeler"),
              ),
              ListTile(
                leading: Icon(CupertinoIcons.home),
                title: Text("Adresler"),
              ),
              ListTile(
                leading: Icon(CupertinoIcons.person),
                title: Text("Hesap detayları"),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Oturumu kapat"),
              )
            ],
          ),
          shape: Border.all(width: 0),
          shadowColor: Colors.black,
          elevation: 10,
          backgroundColor: AppColors.secondary,
        ),
    );
  }
}
