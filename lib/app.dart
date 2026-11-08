import 'package:bdcalling_class/view/splash/splash_screen.dart';
import 'package:bdcalling_class/view/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'controller_binder.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinder(),
      home: const SplashScreen(),
      theme: AppTheme.light,
    );
  }
}
