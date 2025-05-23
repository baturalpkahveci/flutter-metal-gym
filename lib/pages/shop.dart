import 'package:flutter/material.dart';
import 'package:metal_gym_mobile_application/common/widgets/product_box.dart';
import 'package:metal_gym_mobile_application/core/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:metal_gym_mobile_application/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:metal_gym_mobile_application/providers/category_provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  static const phoneNumber = "+905414105283";
  static const mail = "info@metalgymturkey.com";
  static const location = "Meriç Mah. 5646 Sokak No:19 Bornova/İzmir";

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String _searchQuery = '';
  String _selectedCategory = 'all';
  String _selectedOrder = 'popular';
  bool _isLoadingNextPage = false;  // Flag for pagination loading

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);

    if (productProvider.products.isEmpty) {
      productProvider.fetchProducts();  // Fetch initial products
    }

    if (categoryProvider.categories.isEmpty) {
      categoryProvider.fetchCategories();  // Fetch categories if not already available
    }
  }

  Future<void> _refreshPage() async {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    productProvider.resetPageAndProducts(); // Reset page and products

    // Fetch the first page of products again with the current selected category and order
    await productProvider.fetchProducts();

    // Apply filters and sorting based on the selected category and order
    productProvider.filterAndSortProducts(
      category: _selectedCategory,
      sortOrder: _selectedOrder,
    );
  }

  @override
  Widget build(BuildContext newContext) {
    final productProvider = Provider.of<ProductProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    int crossAxisCount = (screenWidth / 150).floor();
    crossAxisCount = crossAxisCount < 1 ? 1 : crossAxisCount;

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
                    ),
                  ]);
            },
            icon: Icon(Icons.phone),
          )
        ],
      ),
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: _refreshPage, // Trigger the refresh
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
          child: Column(
            verticalDirection: VerticalDirection.down,
            children: [
              Column(
                children: [
                  SizedBox(height: screenHeight * 0.03),
                  SearchBar(
                    hintText: 'Ürün Ara...',
                    leading: Container(
                      padding: EdgeInsets.all(screenWidth * 0.025),
                      child: Icon(Icons.search),
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                      // Call the search function when a new query is submitted
                      productProvider.searchProducts(_searchQuery);
                    },
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Category Dropdown
                      Flexible(
                        child: DropdownButton<String>(
                          value: _selectedCategory,
                          icon: const Icon(Icons.apps_outlined),
                          iconDisabledColor: AppColors.priceColor,
                          iconEnabledColor: AppColors.highlighted,
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: AppColors.priceColor, fontSize: 12),
                          underline: Container(
                            height: 2,
                            color: AppColors.highlighted,
                          ),
                          dropdownColor: AppColors.primary,

                          onChanged: (newValue) {
                            setState(() {
                              _selectedCategory = newValue!;
                            });
                            // Apply filter with the current selected category
                            productProvider.filterAndSortProducts(
                              category: _selectedCategory,
                              sortOrder: _selectedOrder,
                            );
                          },
                          items: [
                            DropdownMenuItem(value: 'all', child: Text("Hepsi")),
                            ...categoryProvider.categories.map(
                                  (category) => DropdownMenuItem(
                                value: category.slug,
                                child: Text(category.name),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02), // Add spacing between dropdowns
                      // Sort Order Dropdown
                      Flexible(
                        child: DropdownButton<String>(
                          value: _selectedOrder,
                          icon: const Icon(Icons.sort_by_alpha),
                          iconDisabledColor: AppColors.priceColor,
                          iconEnabledColor: AppColors.highlighted,
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: AppColors.priceColor, fontSize: 12),
                          underline: Container(
                            height: 2,
                            color: AppColors.highlighted,
                          ),
                          dropdownColor: AppColors.primary,

                          onChanged: (newValue) {
                            setState(() {
                              _selectedOrder = newValue!;
                            });
                            // Apply sorting with the current selected order
                            productProvider.filterAndSortProducts(
                              category: _selectedCategory,
                              sortOrder: _selectedOrder,
                            );
                          },
                          items: [
                            DropdownMenuItem(value: 'popular', child: Text("En Popüler")),
                            DropdownMenuItem(value: 'ascending', child: Text("Artan")),
                            DropdownMenuItem(value: 'descending', child: Text("Azalan")),
                            DropdownMenuItem(value: 'alphabetical', child: Text("Varsayılan Sıralama")),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              // Get Products
              productProvider.isLoading
                  ? CircularProgressIndicator()
                  : Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 0.48,
                    crossAxisSpacing: screenWidth * 0.01,
                    mainAxisSpacing: screenWidth * 0.01,
                  ),
                  itemCount: productProvider.products.length,
                  itemBuilder: (context, index) {
                    final product = productProvider.products[index];
                    return ProductBox(product: product);
                  },
                  // Pagination
                  controller: ScrollController()
                    ..addListener(() {
                      if (_isLoadingNextPage == false &&
                          productProvider.products.length > 0 &&
                          productProvider.products.length % 20 == 0 &&
                          !productProvider.isLoading) {
                        _isLoadingNextPage = true;
                        productProvider.loadNextPage(_searchQuery).then((_) {
                          setState(() {
                            _isLoadingNextPage = false;
                          });
                        });
                      }
                    }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// LINK FUNCTIONS

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
