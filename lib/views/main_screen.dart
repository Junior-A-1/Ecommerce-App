import 'package:customer_store_app/views/screens/nav_screens/account_screen.dart';
import 'package:customer_store_app/views/screens/nav_screens/cart_screen.dart';
import 'package:customer_store_app/views/screens/nav_screens/category_screen.dart';
import 'package:customer_store_app/views/screens/nav_screens/favourite_screen.dart';
import 'package:customer_store_app/views/screens/nav_screens/home_screen.dart';
import 'package:customer_store_app/views/screens/nav_screens/store_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _pages = [
    HomeScreen(),
    FavouriteScreen(),
    
    CategoryScreen(),
    StoreScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.black,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
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
      body: _pages[_pageIndex],
    );
  }
}
