import 'dart:convert';

import 'package:customer_store_app/models/user.dart';
import 'package:customer_store_app/provider/user_provider.dart';
import 'package:customer_store_app/services/manage_http_response.dart';
import 'package:customer_store_app/views/main_screen.dart';
import 'package:customer_store_app/views/screens/authentication_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:customer_store_app/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final providerContainer = ProviderContainer();

class AuthController {
  Future<void> signUpUser({
    required context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      User user = User(
          id: '',
          fullName: fullName,
          email: email,
          state: '',
          city: '',
          locality: '',
          password: password,
          token: ' ');
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            //ontent-Type: Tells the server what type of data is being sent.
            //application/json: Indicates that the data is in JSON format.

            //UTF-8 (Unicode Transformation Format - 8-bit)
            //When you send data to a server,
            //you need to ensure that both the server and client (your app) agree on how text is encoded.
            // By specifying charset=UTF-8, you ensure that:
            "Content-Type": "application/json; charset=UTF-8"
          });

      manageHtttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
            showSnackBar(context, 'ACCOUNT HAS BEEN CREATED SUCCESSFULLY');
          });
    } catch (e) {
      print("Error: $e");
    }
  }

  //singin user function
  Future<void> signInUser(
      {required context, required email, required password}) async {
    try {
      http.Response response = await http.post(Uri.parse('$uri/api/signin/'),
          body: jsonEncode(
            {
              'email': email,
              'password': password,
            },
          ),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      manageHtttpResponse(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();

            String token = jsonDecode(response.body)['token'];

            await preferences.setString('auth_token', token);

            final userJson = jsonEncode(jsonDecode(response.body)['user']);

            providerContainer.read(userProvider.notifier).setUser(userJson);

            await preferences.setString('user', userJson);

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
                (route) => false);
            showSnackBar(context, 'LOGGED IN SUCCESSFULLY');
          });
    } catch (e) {
      print("Error: $e");
    }
  }

  //signout
  Future<void> signOutUser({required context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      //clear the token and user from sharedpreference
      await preferences.remove('auth_token');
      await preferences.remove('user');
      //clear the user state
      providerContainer.read(userProvider.notifier).signOut();

      //navigate the user back to login screen
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }), (route) => false);

      showSnackBar(context, 'Sign Out Successfully');
    } catch (e) {
      showSnackBar(context, 'Error SigningOut ');
    }
  }
}
