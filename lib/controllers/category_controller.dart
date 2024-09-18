import 'dart:convert';

import 'package:app_web/global_variables.dart';
import 'package:app_web/models/category.dart';
import 'package:app_web/services/manage_hhtp_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  uploadCategory(
      {required dynamic pickedImage,
      required dynamic pickedBanner,
      required String name,
      required context}) async {
    try {
      final cloudinary = CloudinaryPublic("dvssiuyga", 'jpftcaqm');

      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage,
            identifier: 'pickedImage', folder: 'categoryImages'),
      );

      String image = imageResponse.secureUrl;

      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedBanner,
            identifier: 'pickedBanner', folder: 'categoryImages'),
      );

      String banner = bannerResponse.secureUrl;

      Category category =
          Category(id: "", name: name, image: image, banner: banner);
      http.Response response = await http.post(
        Uri.parse('$uri/api/category'),
        body: category.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      manageHtttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Uploaded category');
          });
    } catch (e) {
      print('error uploading to cloudinary :$e');
    }
  }

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
