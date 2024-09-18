import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_store_app/global_variable.dart';
import 'package:vendor_store_app/models/vendor.dart';
import 'package:http/http.dart' as http;
import 'package:vendor_store_app/provider/vendor_provider.dart';
import 'dart:convert';

import 'package:vendor_store_app/services/manage_http_response.dart';
import 'package:vendor_store_app/views/screens/main_vendor_screen.dart';

final providerContainer = ProviderContainer();

class Vendor_Controller {
  Future<void> signUpVendor({
    required context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      Vendor vendor = Vendor(
          id: '',
          fullName: fullName,
          email: email,
          state: '',
          city: '',
          locality: '',
          role: '',
          password: password,
          token: '');

//sign up
      http.Response response = await http.post(
          Uri.parse('$uri/api/vendor/signup'),
          body: vendor.toJson(),
          headers: <String, String>{
            //ontent-Type: Tells the server what type of data is being sent.
            //application/json: Indicates that the data is in JSON format.

            //UTF-8 (Unicode Transformation Format - 8-bit)
            //When you send data to a server,
            //you need to ensure that both the server and client (your app) agree on how text is encoded.
            // By specifying charset=UTF-8, you ensure that:
            "Content-Type": "application/json; charset=UTF-8"
          });

      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, 'VENDOR ACCOUNT HAS BEEN CREATED SUCCESSFULLY');
          });
    } catch (e) {
      print("Error: $e");
    }
  }

//sign in
  Future<void> signInVendor({
    required context,
    required email,
    required password,
  }) async {
    try {
      http.Response response =
          await http.post(Uri.parse('$uri/api/vendor/signin'),
              body: jsonEncode({
                'email': email,
                'password': password,
              }),
              headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            String token = jsonDecode(response.body)['token'];
            await preferences.setString('auth_token', token);

            final vendorJson = jsonEncode(jsonDecode(response.body)['vendor']);
            providerContainer
                .read(vendorProvider.notifier)
                .setVendor(vendorJson);

            await preferences.setString('vendor', vendorJson);

            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return const MainVendorScreen();
            }), (route) => false);
            showSnackBar(context, 'LOGGED IN SUCCESSFULLY');
          });
    } catch (e) {
      print("Error: $e");
    }
  }
}
