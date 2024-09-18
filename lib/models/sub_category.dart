import 'dart:convert';

class SubCategory {
  final String id;
  final String categoryId;
  final String categoryName;
  final String image;
  final String subCategoryName;

  SubCategory({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.image,
    required this.subCategoryName,
  });

  // Convert a SubCategory object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'image': image,
      'subCategoryName': subCategoryName,
    };
  }

// Encode a SubCategory object to JSON
  String toJson() => json.encode(toMap());

  // Create a SubCategory object from a Map
  factory SubCategory.fromJson(Map<String, dynamic> map) {
    return SubCategory(
      id: map['_id'] as String,
      categoryId: map['categoryId'] as String,
      categoryName: map['categoryName'] as String,
      image: map['image'] as String,
      subCategoryName: map['subCategoryName'] as String,
    );
  }
}
