import 'package:famous_gadget/view/splash/splash_screen.dart';
import 'package:famous_gadget/view/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/theme_controller.dart';
import 'controller_binder.dart';
import 'view/navigation/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: ControllerBinder(),
        initialRoute: null,
        home: const SplashScreen(),
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeController.themeMode,
        getPages: AppRoutePages.pages,
      ),
    );
  }
}
