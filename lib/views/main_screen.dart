import 'package:app_web/views/size_bar_screens/buyers_screen.dart';
import 'package:app_web/views/size_bar_screens/categories_screeen.dart';
import 'package:app_web/views/size_bar_screens/orders_screen.dart';
import 'package:app_web/views/size_bar_screens/products_screen.dart';
import 'package:app_web/views/size_bar_screens/sub_categories_screen.dart';
import 'package:app_web/views/size_bar_screens/upload_banners_screen.dart';
import 'package:app_web/views/size_bar_screens/vendors_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _onSelectedScreen = const VendorsScreen();

  screenSelector(items) {
    switch (items.route) {
      case BuyersScreen.id:
        setState(() {
          _onSelectedScreen = const BuyersScreen();
        });
        break;
      case VendorsScreen.id:
        setState(() {
          _onSelectedScreen = const VendorsScreen();
        });
        break;
      case OrdersScreen.id:
        setState(() {
          _onSelectedScreen = const OrdersScreen();
        });
        break;
      case CategoriesScreen.id:
        setState(() {
          _onSelectedScreen = const CategoriesScreen();
        });
        break;
      case SubCategoriesScreen.id:
        setState(() {
          _onSelectedScreen = const SubCategoriesScreen();
        });
        break;
      case UploadBannersScreen.id:
        setState(() {
          _onSelectedScreen = const UploadBannersScreen();
        });
        break;
      case ProductsScreen.id:
        setState(() {
          _onSelectedScreen = const ProductsScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      body: _onSelectedScreen,
      sideBar: SideBar(
        borderColor: const Color.fromARGB(64, 255, 82, 82),
        backgroundColor: Colors.black,
        header: Container(
          height: 50,
          width: double.infinity,
          color: Colors.black54,
          child: const Center(
            child: Text(
              'Multi Vendor Admin ',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.7,
                  color: Color.fromARGB(61, 5, 5, 5)),
            ),
          ),
        ),
        items: const [
          AdminMenuItem(
              title: 'Vendors',
              route: VendorsScreen.id,
              icon: CupertinoIcons.person_3),
          AdminMenuItem(
              title: 'Buyers',
              route: BuyersScreen.id,
              icon: CupertinoIcons.person),
          AdminMenuItem(
              title: 'Orders',
              route: OrdersScreen.id,
              icon: CupertinoIcons.cart),
          AdminMenuItem(
              title: 'Categories',
              route: CategoriesScreen.id,
              icon: Icons.category),
          AdminMenuItem(
              title: 'Sub Categories',
              route: SubCategoriesScreen.id,
              icon: Icons.category_rounded),
          AdminMenuItem(
              title: 'Upload Banners',
              route: UploadBannersScreen.id,
              icon: CupertinoIcons.bandage),
          AdminMenuItem(
              title: 'Products',
              route: ProductsScreen.id,
              icon: Icons.production_quantity_limits),
        ],
        selectedRoute: '',
        onSelected: (items) {
          screenSelector(items);
        },
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 158, 158, 158),
        title: const Text('Management'),
      ),
    );
  }
}
