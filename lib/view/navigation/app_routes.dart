import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'app_navigation.dart';
import 'routes/account_routes.dart';
import 'routes/catalog_routes.dart';
import 'routes/checkout_routes.dart';
import 'routes/home_routes.dart';

class AppRoutePages {
  AppRoutePages._();

  static String get initialRoute => kIsWeb ? initialWebRoute : AppRoutes.splash;

  static String get initialWebRoute {
    final path = Uri.base.path;
    if (path.isNotEmpty && path != '/') return path;

    final fragmentPath = Uri.base.fragment.split('?').first;
    if (fragmentPath.startsWith('/') && fragmentPath != '/') {
      return fragmentPath;
    }
    return AppRoutes.home;
  }

  static WebHistoryGetDelegate get webRouterDelegate =>
      Get.routerDelegate as WebHistoryGetDelegate? ?? WebHistoryGetDelegate();

  static GetInformationParser get webRouteInformationParser =>
      Get.createInformationParser(initialRoute: initialWebRoute);

  static List<GetPage<void>> get pages => [
    ...HomeRoutes.pages,
    ...CatalogRoutes.pages,
    ...AccountRoutes.pages,
    ...CheckoutRoutes.pages,
  ];

  static List<GetPage<void>> get webPages =>
      pages.where((page) => page.name != AppRoutes.splash).toList();
}
