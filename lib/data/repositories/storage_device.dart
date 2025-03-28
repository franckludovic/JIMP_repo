
import 'package:get_storage/get_storage.dart';

class StorageService {
  static final _box = GetStorage();

  static const String userTypeKey = 'user_type';

  static Future<void> saveUserType(String userType) async {
    await _box.write(userTypeKey, userType);
  }

  static String? getUserType() {
    return _box.read<String>(userTypeKey);
  }

  static Future<void> clearUserType() async {
    await _box.remove(userTypeKey);
  }
}
