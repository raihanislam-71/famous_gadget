import 'dart:developer' as developer;

import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const home = '/home';
  static const categories = '/categories';
  static const subCategory = '/categories/subcategory';
  static const products = '/products';
  static const search = '/search';
  static const productDetails = '/products/details';
  static const outOfStockProduct = '/products/out-of-stock';
  static const cart = '/cart';
  static const account = '/account';
  static const login = '/account/login';
  static const register = '/account/register';
  static const otp = '/account/verify';
  static const editProfile = '/account/edit-profile';
  static const changePassword = '/account/change-password';
  static const addresses = '/account/addresses';
  static const addressForm = '/account/addresses/edit';
  static const orders = '/account/orders';
  static const orderDetails = '/account/orders/details';
  static const wishlist = '/account/wishlist';
  static const checkoutDelivery = '/checkout/delivery';
  static const checkoutConfirmation = '/checkout/confirmation';
  static const orderSuccess = '/checkout/success';
  static const reviews = '/products/reviews';

  static Future<T?>? toNamed<T>({
    required String route,
    Object? arguments,
    bool preventDuplicates = true,
  }) {
    _logNavigation('push', route);
    return Get.toNamed<T>(
      _routePath(route, arguments),
      arguments: arguments,
      preventDuplicates: preventDuplicates,
    );
  }

  static Future<T?>? offNamed<T>({required String route, Object? arguments}) {
    _logNavigation('replace', route);
    return Get.offNamed<T>(_routePath(route, arguments), arguments: arguments);
  }

  static Future<T?>? offAllNamed<T>({
    required String route,
    Object? arguments,
  }) {
    _logNavigation('reset stack', route);
    return Get.offAllNamed<T>(
      _routePath(route, arguments),
      arguments: arguments,
    );
  }

  static void backToHome() {
    _logNavigation('back to home', home);
    Get.offAllNamed<void>(home);
  }

  static bool get canPop => Get.key.currentState?.canPop() ?? false;

  static void back<T>({T? result}) {
    _logNavigation('back', Get.currentRoute);
    Get.back<T>(result: result);
  }

  static void _logNavigation(String action, String route) {
    developer.log('$action: $route', name: 'AppRoutes');
  }

  static String _routePath(String route, Object? arguments) {
    final values = arguments is Map ? arguments : const <Object?, Object?>{};
    String? pathValue(String key) {
      final value = values[key];
      return value is String && value.isNotEmpty
          ? Uri.encodeComponent(value)
          : null;
    }

    switch (route) {
      case subCategory:
        final categoryName = pathValue('categoryName');
        return categoryName == null ? route : '$subCategory/$categoryName';
      case products:
        final categoryName = pathValue('categoryName');
        return categoryName == null ? route : '$products/$categoryName';
      case productDetails:
        final productId = pathValue('productId');
        return productId == null ? route : '$productDetails/$productId';
      case outOfStockProduct:
        final productId = pathValue('productId');
        return productId == null ? route : '$outOfStockProduct/$productId';
      case reviews:
        final productId = pathValue('productId');
        return productId == null ? route : '$reviews/$productId';
      case orderDetails:
        final orderNumber = pathValue('orderNumber');
        return orderNumber == null ? route : '$orderDetails/$orderNumber';
      default:
        return route;
    }
  }
}
