import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static final PreferenceManager _instance = PreferenceManager._init();
  static SharedPreferences? _pref;

  factory PreferenceManager() => _instance;
  PreferenceManager._init();

  init() async {
    _pref = await SharedPreferences.getInstance();
  }

  Future<bool> putBool(String key, bool value) async {
    return _pref!.setBool(key, value);
  }

  bool getBool(String key) {
    return _pref!.getBool(key)!;
  }

  Future<bool> putInt(String key, int value) async {
    return _pref!.setInt(key, value);
  }

  int getInt(String key) {
    if (_pref!.containsKey(key)) {
      return _pref!.getInt(key)!;
    }
    return -1;
  }

  Future<bool> putString(String key, String value) async {
    return _pref!.setString(key, value);
  }

  String? getString(String key) {
      return _pref?.getString(key)!;
  }

  Future<bool> remove(String key) {
    return _pref!.remove(key);
  }
}