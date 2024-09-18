import 'dart:convert';

class BannerModel {
  final String id;
  final String image;

  BannerModel({
    required this.id,
    required this.image,
  });

  // Convert a Category object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
    };
  }

  // Encode a Category object to JSON
  String toJson() => json.encode(toMap());

  // Create a Category object from a Map
  factory BannerModel.fromJson(Map<String, dynamic> map) {
    return BannerModel(
      id: map['_id'] as String,
      image: map['image'] as String,
    );
  }

  // // Decode a Category object from JSON
  // factory BannerModel.fromJson(String source) =>
  //     BannerModel.fromMap(json.decode(source));
}
