import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:metal_gym_mobile_application/providers/user_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).currentUser;
    //TO DO: Find out how to log in with wc rest api and save the current user to flutter
    //Research about JWT Tokens and login with wc rest api

    return Scaffold(
        appBar: AppBar(
          title: Text("Profil"),
        ),
        body: Center(
          child: ListView(
            addRepaintBoundaries: true,
            children: [
              ListTile(
                leading: Icon(CupertinoIcons.device_phone_portrait),
                title: Text("Pano"),
                iconColor: AppColors.primary,
                textColor: AppColors.secondary,
                onTap: () {

                },
              ),

              ListTile(
                leading: Icon(Icons.shopping_basket_outlined),
                title: Text("Siparişler"),
                iconColor: AppColors.primary,
                textColor: AppColors.secondary,
                onTap: () {

                },
              ),
              ListTile(
                leading: Icon(CupertinoIcons.arrow_down_doc),
                title: Text("İndirmeler"),
                iconColor: AppColors.primary,
                textColor: AppColors.secondary,
                onTap: () {

                },
              ),
              ListTile(
                leading: Icon(CupertinoIcons.home),
                title: Text("Adresler"),
                iconColor: AppColors.primary,
                textColor: AppColors.secondary,
                onTap: () {

                },
              ),
              ListTile(
                leading: Icon(CupertinoIcons.person),
                title: Text("Hesap detayları"),
                iconColor: AppColors.primary,
                textColor: AppColors.secondary,
                onTap: () {

                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Oturumu kapat"),
                iconColor: AppColors.highlighted,
                textColor: AppColors.highlighted,
                splashColor: AppColors.highlighted,
                onTap: () {

                },
              )
            ],
          ),
        ),
    );
  }
}
