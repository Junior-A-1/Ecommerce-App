import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vendor_store_app/views/screens/nav_screens/earnings_screen.dart';
import 'package:vendor_store_app/views/screens/nav_screens/edit_screen.dart';
import 'package:vendor_store_app/views/screens/nav_screens/orders_screen.dart';
import 'package:vendor_store_app/views/screens/nav_screens/profile_screen.dart';
import 'package:vendor_store_app/views/screens/nav_screens/upload_screen.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  final List<Widget> _page = [
    const EarningsScreen(),
    const UploadScreen(),
    const EditScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];

  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndex,
          onTap: (value) {
            setState(() {
              _pageIndex = value;
            });
          },
          unselectedItemColor: Colors.grey,
          selectedItemColor: const Color.fromARGB(255, 3, 49, 110),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.money_dollar), label: "Earnings"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.upload_circle), label: "Upload"),
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: "Edit"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.shopping_cart), label: "Orders"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
    );
  }
}
