import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:partquotes_admin/models/user_model.dart';

class UserService {
  static final box = GetStorage();

  static void saveUser(UserData user) {
    box.write('user', user.toJson());
  }

  static UserData? getUser() {
    final userData = box.read('user');
    if (userData != null) {
      return UserData.fromJson(Map<String, dynamic>.from(userData));
    } else {
      return null;
    }
  }
}
