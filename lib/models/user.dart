import 'dart:convert';

class User {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String token;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
    required this.token,
  });

  // Method to convert User object to a Map (serialization)

  //IMP NOTE
  //The User class methods like **toMap and **toJson facilitate converting
  //user data into formats required for database storage or API communication.

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'password': password,
      'token': token,
    };
  }
  //We can do it with the List concept also (To convert the user object to map(Serialization))
  //BUT I AM COMMENTING IT OUT B/C MAP PROVIDE CLEAR STRUCTURE WITH KEY VALUE PAIRS
//  List<dynamic> toList(){
//   return[
//     id,fullName,email,state,city,locality,password
//   ];
//  }

//The toJson method calls json.encode(toMap()), which converts the Map to a JSON string.
  String toJson() => json.encode(toMap());

//When you receive data from an external source (like a server, file, or database)
//, it is usually in a serialized format such as JSON.
// Your application needs to convert this data
//back into a format it can understand and manipulate
//, like a class instance or an object.

//IMP NOTE
//Similarly, when receiving user data from a server,
//you can convert it into a User object using fromMap.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String? ?? " ",
      fullName: map['fullName'] as String? ?? " ",
      email: map['email'] as String? ?? " ",
      state: map['state'] as String? ?? " ",
      city: map['city'] as String? ?? " ",
      locality: map['locality'] as String? ?? " ",
      password: map['password'] as String? ?? " ",
      token: map['token'] as String? ?? " ",
    );
    //as String?: This is a type cast operation.
    //It tells Dart to treat the value from the map as a String? (nullable String).
    //The ? indicates that the value can be null, meaning it’s allowed to have no value.

//?? "": This is the null-coalescing operator.
//It provides a default value if the value on the left is null.
//If the value from the map is null,
//it will use the default value on the right side of ??.
//In this case, it defaults to an empty string "".
  }

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
