import 'dart:convert';

class Category {
  final String id;
  final String name;
  final String image;
  final String banner;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.banner,
  });

  // Convert a Category object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'banner': banner,
    };
  }

  // Create a Category object from a Map
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['_id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      banner: map['banner'] as String,
    );
  }

  // Encode a Category object to JSON
  String toJson() => json.encode(toMap());

  // Decode a Category object from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      banner: json['banner'] as String,
    );
  }
}
