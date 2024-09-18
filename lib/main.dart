import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_store_app/provider/vendor_provider.dart';
import 'package:vendor_store_app/views/authentication_screens/login_screen.dart';
import 'package:vendor_store_app/views/screens/main_vendor_screen.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> checkTokenAndSetUser(WidgetRef ref) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('auth_token');
      String? vendorJson = preferences.getString('vendor');

      if (token != null && vendorJson != null) {
        ref.read(vendorProvider.notifier).setVendor(vendorJson);
      } else {
        ref.read(vendorProvider.notifier).signOut();
      }
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
          future: checkTokenAndSetUser(ref),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final vendor = ref.watch(vendorProvider);

            return vendor != null ? const MainVendorScreen() : LoginScreen();
          }),
    );
  }
}
