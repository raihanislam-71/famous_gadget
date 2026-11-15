import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../app_navigation.dart';
import '../web_page_frame.dart';

class RouteHelpers {
  RouteHelpers._();

  static Widget webPage(Widget child) {
    if (!kIsWeb) return child;

    return Builder(
      builder: (context) {
        // Tablet and smaller web viewports use the same mobile-style shell.
        // The desktop web header starts only at the app's desktop breakpoint.
        return MediaQuery.sizeOf(context).width < 1100
            ? child
            : WebPageFrame(child: child);
      },
    );
  }

  static Object? objectArgument(String key) {
    final arguments = Get.arguments;
    return arguments is Map ? arguments[key] : null;
  }

  static String stringArgument(String key, {String fallback = ''}) {
    final parameter = Get.parameters[key];
    if (parameter != null) return parameter;
    final value = objectArgument(key);
    return value is String ? value : fallback;
  }

  static bool boolArgument(String key) => objectArgument(key) == true;

  static void Function()? callbackArgument(String key) {
    final value = objectArgument(key);
    return value is void Function() ? value : null;
  }

  static void finishDirectLogin() {
    Get.find<AuthController>().completeDemoAuthentication();
    Get.offAllNamed<void>(AppRoutes.home);
  }
}
