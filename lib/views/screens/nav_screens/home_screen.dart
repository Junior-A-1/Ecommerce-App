import 'package:customer_store_app/views/screens/nav_screens/widgets/banner_widget.dart';
import 'package:customer_store_app/views/screens/nav_screens/widgets/category_widget.dart';
import 'package:customer_store_app/views/screens/nav_screens/widgets/header_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          HeaderWidget(),
          BannerWidget(),
          CategoryWidget(),
        ],
      ),
    );
  }
}
