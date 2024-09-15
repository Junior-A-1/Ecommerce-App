import 'dart:convert';

import 'package:customer_store_app/global_variable.dart';
import 'package:customer_store_app/models/banner_model.dart';

import 'package:http/http.dart' as http;

class BannerController {
//fetch banner
  Future<List<BannerModel>> loadBanners() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          "Content-Type": "application/json; charset = UTF-8"
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        // List<dynamic> data = jsonDecode(response.body);
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['banners'];
        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList();
        return banners;
      } else {
        throw Exception('Failed to Load Banners');
      }
    } catch (e) {
      throw Exception('Error loading Banners $e');
    }
  }
}
