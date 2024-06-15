
import 'package:get_storage/get_storage.dart';

class MainLocaleStorage{
  static final MainLocaleStorage _instance = MainLocaleStorage._internal();

  factory MainLocaleStorage(){
    return _instance;
  }

  MainLocaleStorage._internal();

  final _storage = GetStorage();

  // Generic Method Save Data 
  Future<void> saveDate<T>(String key, T value) async{
    await _storage.write(key, value);
  }

  // Generic Method Save Data 
  T? readDate<T>(String key) {
    return _storage.read<T>(key);
  }

  //  Method Remove Data 
  Future<void> removeDate(String key,) async{
    await _storage.remove(key);
  }
  //  Clear Data 
  Future<void> clearAll() async{
    await _storage.erase();
  }

}