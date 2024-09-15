import 'package:customer_store_app/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//StateNotifier is the property of riverpod and it help us to keep track of user state
class UserProvider extends StateNotifier<User?> {
  UserProvider()
      : super(User(
            id: '',
            fullName: '',
            email: '',
            state: '',
            city: '',
            locality: '',
            password: '',
            token: ''));

  User? get user => state;

  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }

  void signOut() {
    state = null;
  }
}

final userProvider = StateNotifierProvider((ref) => UserProvider());
