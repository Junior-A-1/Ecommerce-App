import 'package:customer_store_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final AuthController _authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await _authController.signOutUser(context: context);
        },
        child: const Text('Sign Out'),
      ),
    );
  }
}
