import 'dart:convert';

import 'package:app_web/global_variables.dart';
import 'package:app_web/models/banner_model.dart';
import 'package:app_web/services/manage_hhtp_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

class BannerController {
  uploadBanner({required dynamic pickedImage, required context}) async {
    try {
      final cloudinary = CloudinaryPublic("dvssiuyga", 'jpftcaqm');

      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage,
            identifier: 'pickedImage', folder: 'bannerImages'),
      );

      String image = imageResponse.secureUrl;

      BannerModel bannerModel = BannerModel(id: "", image: image);
      http.Response response = await http.post(
        Uri.parse('$uri/api/banner'),
        body: bannerModel.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      manageHtttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Uploaded banner !');
          });
    } catch (e) {
      print('error uploading to cloudinary :$e');
    }
  }

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
