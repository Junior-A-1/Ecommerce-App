import 'dart:convert';

import 'package:customer_store_app/global_variable.dart';
import 'package:customer_store_app/models/category.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  Future<List<Category>> loadCategory() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/category'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8'
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Category> categorys = data
            .map((category) =>
                Category.fromJson(category as Map<String, dynamic>))
            .toList();
        return categorys;
      } else {
        throw Exception('Failed to Load Category');
      }
    } catch (e) {
      throw Exception('Error loading Categories  $e');
    }
  }
}
