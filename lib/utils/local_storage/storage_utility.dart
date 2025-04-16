import 'package:get_storage/get_storage.dart';

class JLocalStorage {

  late final GetStorage _storage;

  static JLocalStorage? _instance;

  JLocalStorage._internal();

  factory JLocalStorage.instance() {
     _instance ??=JLocalStorage._internal();
     return _instance!;
  }

  static Future<void> init(String bucketName) async{
    await GetStorage.init(bucketName);
    _instance = JLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }


  // Generic method to save data
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  // Generic method to read data
  J? readData<J>(String key) {
    return _storage.read<J>(key);
  }

  // Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  // Clear all data in storage
  Future<void> clearAll() async {
    await _storage.erase();
  }
}


/// *** *** *** *** *** Example *** *** *** *** *** ///

// LocalStorage localStorage = LocalStorage();
//
// // Save data
// localStorage.saveData('username', 'JohnDoe');
//
// // Read data
// String? username = localStorage.readData<String>('username');
// print('Username: $username'); // Output: Username: JohnDoe
//
// // Remove data
// localStorage.removeData('username');
//
// // Clear all data
// localStorage.clearAll();

