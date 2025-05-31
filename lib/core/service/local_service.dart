import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  late SharedPreferences _prefs;

  LocalStorageService._internal();

  static LocalStorageService get instance => _instance;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // String
  Future<void> setString(String key, String value) async =>
      await _prefs.setString(key, value);

  String? getString(String key) => _prefs.getString(key);

  // Bool
  Future<void> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);

  bool? getBool(String key) => _prefs.getBool(key);

  // Int
  Future<void> setInt(String key, int value) async =>
      await _prefs.setInt(key, value);

  int? getInt(String key) => _prefs.getInt(key);

  // Double
  Future<void> setDouble(String key, double value) async =>
      await _prefs.setDouble(key, value);
  double? getDouble(String key) => _prefs.getDouble(key);

  // List<String>
  Future<void> setStringList(String key, List<String> value) async =>
      await _prefs.setStringList(key, value);

  List<String>? getStringList(String key) => _prefs.getStringList(key);

  // Remove key
  Future<void> remove(String key) async => await _prefs.remove(key);

  // Clear all
  Future<void> clear() async => await _prefs.clear();
}
