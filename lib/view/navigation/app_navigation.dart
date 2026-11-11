import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._();

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

  static Future<T?>? to<T>({
    required String route,
    required Widget Function() mobileBuilder,
    Object? arguments,
  }) {
    if (kIsWeb) {
      return Get.toNamed<T>(
        _webRoute(route, arguments),
        arguments: arguments,
      );
    }
    return Get.to<T>(mobileBuilder);
  }

  static Future<T?>? off<T>({
    required String route,
    required Widget Function() mobileBuilder,
    Object? arguments,
  }) {
    if (kIsWeb) {
      return Get.offNamed<T>(
        _webRoute(route, arguments),
        arguments: arguments,
      );
    }
    return Get.off<T>(mobileBuilder);
  }

  static Future<T?>? offAll<T>({
    required String route,
    required Widget Function() mobileBuilder,
    Object? arguments,
  }) {
    if (kIsWeb) {
      return Get.offAllNamed<T>(
        _webRoute(route, arguments),
        arguments: arguments,
      );
    }
    return Get.offAll<T>(mobileBuilder);
  }

  static void backToHome() {
    if (kIsWeb) {
      Get.offAllNamed<void>(home);
    } else {
      Get.back<void>();
    }
  }

  static String _webRoute(String route, Object? arguments) {
    final values = arguments is Map ? arguments : const <Object?, Object?>{};
    String pathValue(String key) {
      final value = values[key];
      return Uri.encodeComponent(value is String ? value : '');
    }

    switch (route) {
      case subCategory:
        return '$subCategory/${pathValue('categoryName')}';
      case products:
        return '$products/${pathValue('categoryName')}';
      case productDetails:
        return '$productDetails/${pathValue('productId')}';
      case outOfStockProduct:
        return '$outOfStockProduct/${pathValue('productId')}';
      case reviews:
        return '$reviews/${pathValue('productId')}';
      case orderDetails:
        return '$orderDetails/${pathValue('orderNumber')}';
      default:
        return route;
    }
  }
}
