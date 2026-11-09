import 'package:bdcalling_class/view/splash/splash_screen.dart';
import 'package:bdcalling_class/view/utils/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'controller_binder.dart';
import 'view/home/web_home_screen.dart';
import 'view/navigation/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinder(),
      initialRoute: kIsWeb ? AppRoutePages.initialWebRoute : null,
      home: kIsWeb ? const WebHomeScreen() : const SplashScreen(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      getPages: AppRoutePages.pages,
    );
  }
}
