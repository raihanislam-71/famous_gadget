import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app.dart';
import 'controllers/theme_controller.dart';

void main() {
  Get.put(ThemeController(), permanent: true);
  runApp(const MyApp());
}