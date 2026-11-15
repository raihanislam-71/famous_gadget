import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../app_navigation.dart';
import '../web_page_frame.dart';

class RouteHelpers {
  RouteHelpers._();

  static Widget webPage(Widget child) =>
      kIsWeb ? WebPageFrame(child: child) : child;

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
