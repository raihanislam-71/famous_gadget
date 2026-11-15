import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../home/home_screen.dart';
import '../main_bottom_nav_screen.dart';
import '../app_navigation.dart';

class HomeRoutes {
  HomeRoutes._();

  static List<GetPage<void>> get pages => [
    GetPage<void>(name: AppRoutes.home, page: () => const HomeRouteEntry()),
  ];
}

class HomeRouteEntry extends StatelessWidget {
  const HomeRouteEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth < 1100
            ? const MainBottomNavScreen()
            : const HomeScreen();
      },
    );
  }
}
