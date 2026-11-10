import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;
  ThemeMode get themeMode =>
      _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    Get.changeThemeMode(themeMode);
    update();
  }
}
