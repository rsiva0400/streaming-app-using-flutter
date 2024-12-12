import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {
  // prevent making instance
  MySharedPref._();

  // get storage
  static late SharedPreferences _sharedPreferences;


  /// init get storage services
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static setStorage(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
  }

  /// clear all data from shared pref
  static Future<void> clear() async => await _sharedPreferences.clear();

  /// gets string lsit
  static List<String> getList(String key) {
    return _sharedPreferences.getStringList(key) ?? [];
  }
  /// adds new item to string list
  static Future<List<String>> addToList(String key, String value) async {
    List<String> val = getList(key);
    val.add(value);
    _sharedPreferences.setStringList(key, val);
    return val;
  }

  static Future<List<String>> removeFromList(String key, String value) async {
    List<String> val = getList(key);
    val.remove(value);
    _sharedPreferences.setStringList(key, val);
    return val;
  }


}