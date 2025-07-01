// lib/controllers/theme_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  final String _key = "isDarkMode";
  late SharedPreferences _prefs;
  late RxBool isDarkMode;

  @override
  void onInit() {
    super.onInit();
    isDarkMode = false.obs;
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    await _initPrefs();
    isDarkMode.value = _prefs.getBool(_key) ?? false;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    await _saveToPrefs();
  }

  Future<void> _saveToPrefs() async {
    await _initPrefs();
    _prefs.setBool(_key, isDarkMode.value);
  }
}
