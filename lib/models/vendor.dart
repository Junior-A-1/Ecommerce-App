import 'dart:convert';

class Vendor {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String role;
  final String password;
  final String token;

  Vendor(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.state,
      required this.city,
      required this.locality,
      required this.role,
      required this.password,
      required this.token});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'role': role,
      'password': password,
      'token': token,
    };
  }

  String toJson() => json.encode(toMap());

  factory Vendor.fromMap(Map<String, dynamic> map) {
    return Vendor(
      id: map['id'] as String? ?? " ",
      fullName: map['fullName'] as String? ?? " ",
      email: map['email'] as String? ?? " ",
      state: map['state'] as String? ?? " ",
      city: map['city'] as String? ?? " ",
      locality: map['locality'] as String? ?? " ",
      role: map['role'] as String? ?? " ",
      password: map['password'] as String? ?? " ",
      token: map['token'] as String? ?? " ",
    );
  }

  factory Vendor.fromJson(String source) =>
      Vendor.fromMap(json.decode(source) as Map<String, dynamic>);
}
