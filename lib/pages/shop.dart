import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/common/widgets/product_box.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});
  //Iletisim bilgileri
  static const phoneNumber = "+905414105283";
  static const mail = "info@metalgymturkey.com";
  static const location = "Meriç Mah. 5646 Sokak No:19 Bornova/İzmir";

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {

    // Calculate screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define the number of columns based on screen width
    int crossAxisCount = (screenWidth / 150).floor(); // Adjust 200 based on your preferred item width
    crossAxisCount = crossAxisCount < 1 ? 1 : crossAxisCount; // Ensure at least 1 column

    // Calculate childAspectRatio for each item to be responsive
    double childAspectRatio = screenWidth / (screenHeight / 1.5);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('MetalGYM'),
        actions: [
          IconButton(
              onPressed: () {
                showAboutDialog(
                    context: context,
                    applicationName: "MetalGYM",
                    applicationVersion: "0.1",
                    children: [
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text("Whatsapp İletişim Hattı: " + ShopPage.phoneNumber),
                        onTap: () {
                          launchWhatsApp(ShopPage.phoneNumber);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.mail),
                        title: Text("Mail: " + ShopPage.mail),
                        onTap: () {
                          launchEmail(ShopPage.mail);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text(ShopPage.location),
                        onTap: () {
                          openGoogleMaps(ShopPage.location);
                        },
                      )
                    ]
                );
              },
              icon: Icon(Icons.phone)
          )
        ],
      ),
      backgroundColor: AppColors.background,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          verticalDirection: VerticalDirection.down,
          children: [
            const SizedBox(height: 15),
            SearchBar(
              leading: Container(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
            Container(
              child: Expanded(
                child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: childAspectRatio,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0
                    ),
                    children: [
                      ProductBox(),
                      ProductBox(),
                      ProductBox(),
                      ProductBox(),
                      ProductBox(),
                      ProductBox(),
                      ProductBox(),
                      ProductBox(),
                      ProductBox(),
                      ProductBox(),
                      ProductBox(),
                      ProductBox(),
                    ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//LINK FUNCTIONS

void launchWhatsApp(String phone) async {
  final whatsappUrl = "https://wa.me/$phone"; // phone number in international format

  if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
    await launchUrl(Uri.parse(whatsappUrl));
  } else {
    throw 'Could not launch $whatsappUrl';
  }
}

void launchEmail(String email) async {
  final emailUrl = Uri(
    scheme: 'mailto',
    path: email,
    query: 'subject=Hello&body=Hi there', // Optional, you can add subject and body
  );

  if (await canLaunchUrl(emailUrl)) {
    await launchUrl(emailUrl);
  } else {
    throw 'Could not launch $emailUrl';
  }
}

void openGoogleMaps(String location) async {
  final googleMapsUrl = Uri(
    scheme: 'https',
    host: 'www.google.com',
    path: '/maps/search/',
    queryParameters: {'q': location},
  );

  if (await canLaunchUrl(googleMapsUrl)) {
    await launchUrl(googleMapsUrl);
  } else {
    throw 'Could not launch $googleMapsUrl';
  }
}


