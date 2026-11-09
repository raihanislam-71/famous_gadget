import 'package:get/get.dart';

import '../view/utils/app_theme.dart';

class ThemeController extends GetxController {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    Get.changeTheme(_isDarkMode ? AppTheme.dark : AppTheme.light);
    update();
  }
}
