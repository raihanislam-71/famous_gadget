import 'package:get/get.dart';
import 'app_navigation.dart';
import 'routes/account_routes.dart';
import 'routes/catalog_routes.dart';
import 'routes/checkout_routes.dart';
import 'routes/home_routes.dart';

class AppRoutePages {
  AppRoutePages._();

  static String get initialWebRoute {
    final path = Uri.base.path;
    if (path.isNotEmpty && path != '/') return path;

    final fragment = Uri.base.fragment;
    if (fragment.startsWith('/')) {
      return fragment.split('?').first;
    }
    return AppRoutes.home;
  }

  static List<GetPage<void>> get pages => [
        ...HomeRoutes.pages,
        ...CatalogRoutes.pages,
        ...AccountRoutes.pages,
        ...CheckoutRoutes.pages,
      ];
}
