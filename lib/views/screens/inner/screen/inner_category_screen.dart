import 'package:customer_store_app/models/category.dart';
import 'package:customer_store_app/views/screens/inner/screen/widget/inner_category_content_widget.dart';
import 'package:customer_store_app/views/screens/nav_screens/account_screen.dart';
import 'package:customer_store_app/views/screens/nav_screens/cart_screen.dart';
import 'package:customer_store_app/views/screens/nav_screens/category_screen.dart';
import 'package:customer_store_app/views/screens/nav_screens/favourite_screen.dart';
import 'package:customer_store_app/views/screens/nav_screens/store_screen.dart';
import 'package:flutter/material.dart';

class InnerCategoryScreen extends StatefulWidget {
  final Category category;
  InnerCategoryScreen({super.key, required this.category});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      InnerCategoryContentWidget(
        category: widget.category,
      ),
      const FavouriteScreen(),
      const CategoryScreen(),
      const StoreScreen(),
      const CartScreen(),
      const AccountScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.black,
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/home.png", width: 25),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/love.png", width: 25),
            label: "Favourite",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/mart.png",
              width: 25,
            ),
            label: "Stores",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/cart.png", width: 25),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/user.png", width: 25),
            label: "Account",
          ),
        ],
      ),
      body: pages[pageIndex],
    );
  }
}
