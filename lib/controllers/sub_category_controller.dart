import 'dart:convert';

import 'package:customer_store_app/global_variable.dart';
import 'package:customer_store_app/models/category.dart';
import 'package:customer_store_app/models/sub_category_model.dart';
import 'package:http/http.dart' as http;

class SubCategoryController {
  Future<List<SubCategory>> getSubCategoryByCategoryName(
      String categoryName) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/category/$categoryName/subcategory'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return data
              .map((subCategory) => SubCategory.fromJson(subCategory))
              .toList();
        } else {
          print("Sub category not found");
          return [];
        }
      } else if (response.statusCode == 404) {
        print("Sub category not found");
        return [];
      } else {
        print("failed to fetch categories");
        return [];
      }
    } catch (e) {
      print("Sub category not found");
      return [];
    }
  }
}
