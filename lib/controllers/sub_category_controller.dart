import 'package:app_web/global_variables.dart';
import 'package:app_web/models/sub_category.dart';
import 'package:app_web/services/manage_hhtp_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubCategoryController {
  uploadSubCategory(
      {required String categoryId,
      required String categoryName,
      required dynamic pickedImage,
      required String subCategoryName,
      required context}) async {
    try {
      final cloudinary = CloudinaryPublic("dvssiuyga", 'jpftcaqm');

      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage,
            identifier: 'pickedImage', folder: 'categoryImages'),
      );
      String image = imageResponse.secureUrl;

      SubCategory subCategory = SubCategory(
          id: " ",
          categoryId: categoryId,
          categoryName: categoryName,
          image: image,
          subCategoryName: subCategoryName);

      http.Response response = await http.post(
        Uri.parse('$uri/api/subcategory'),
        body: subCategory.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      manageHtttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Uploaded Sub Category');
          });
    } catch (e) {
      print('error uploading to cloudinary :$e');
    }
  }

  Future<List<SubCategory>> loadSubCategory() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/subcategory'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8'
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<SubCategory> subcategorys = data
            .map((subcategory) =>
                SubCategory.fromJson(subcategory as Map<String, dynamic>))
            .toList();
        return subcategorys;
      } else {
        throw Exception('Failed to Load Sub Category');
      }
    } catch (e) {
      throw Exception('Error loading Sub Categories  $e');
    }
  }
}
