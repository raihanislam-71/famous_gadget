import 'package:get/get.dart';
import '../../home/web_home_screen.dart';
import '../app_navigation.dart';

class HomeRoutes {
  HomeRoutes._();

  static List<GetPage<void>> get pages => [
        GetPage<void>(name: AppRoutes.home, page: () => const WebHomeScreen()),
      ];
}
