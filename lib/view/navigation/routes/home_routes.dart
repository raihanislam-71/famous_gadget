import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../main_bottom_nav_screen.dart';
import '../app_navigation.dart';
import '../../splash/splash_screen.dart';

class HomeRoutes {
  HomeRoutes._();

  static List<GetPage<void>> get pages => [
    GetPage<void>(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage<void>(name: AppRoutes.home, page: () => const HomeRouteEntry()),
  ];
}

class HomeRouteEntry extends StatelessWidget {
  const HomeRouteEntry({super.key});

  @override
  Widget build(BuildContext context) {
    // Keep the selected tab as the route content at every viewport size.
    // The shell adapts its navigation chrome without swapping to HomeScreen.
    return const MainBottomNavScreen();
  }
}
