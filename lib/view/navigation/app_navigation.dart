import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/bottom_nav_controller.dart';

class AppRoutes {
  AppRoutes._();

  static WebHistoryGetDelegate? get _webDelegate {
    final delegate = Get.routerDelegate;
    return delegate is WebHistoryGetDelegate ? delegate : null;
  }

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
    final path = _routePath(route, arguments);
    final webDelegate = _webDelegate;
    if (webDelegate != null) {
      if (preventDuplicates && path == Get.currentRoute) return null;
      return webDelegate.toNamed<T>(path, arguments: arguments);
    }
    return Get.toNamed<T>(
      path,
      arguments: arguments,
      preventDuplicates: preventDuplicates,
    );
  }

  static Future<T?>? offNamed<T>({required String route, Object? arguments}) {
    _logNavigation('replace', route);
    final path = _routePath(route, arguments);
    final webDelegate = _webDelegate;
    if (webDelegate != null) {
      return webDelegate.offNamed<T>(path, arguments: arguments);
    }
    return Get.offNamed<T>(path, arguments: arguments);
  }

  static Future<T?>? offAllNamed<T>({
    required String route,
    Object? arguments,
  }) {
    _logNavigation('reset stack', route);
    final path = _routePath(route, arguments);
    final webDelegate = _webDelegate;
    if (webDelegate != null) {
      return webDelegate.offAllNamed<T>(path, arguments: arguments);
    }
    return Get.offAllNamed<T>(path, arguments: arguments);
  }

  static Future<void> resetStackToNamed({
    required String route,
    Object? arguments,
  }) {
    _logNavigation('reset stack', route);
    final path = _routePath(route, arguments);
    final webDelegate = _webDelegate;
    if (webDelegate != null) {
      return webDelegate.resetStackTo(path, arguments: arguments);
    }

    Get.offAllNamed<void>(path, arguments: arguments);
    return Future<void>.value();
  }

  static void backToHome() {
    _logNavigation('back to home', home);
    offAllNamed<void>(route: home);
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

class WebHistoryGetDelegate extends GetDelegate {
  WebHistoryGetDelegate()
    : super(
        preventDuplicateHandlingMode:
            PreventDuplicateHandlingMode.PopUntilOriginalRoute,
      );

  @override
  Future<bool> popRoute({Object? result, PopMode popMode = PopMode.Page}) {
    _restoreShellTabBeforePop();
    return super.popRoute(result: result, popMode: PopMode.History);
  }

  @override
  Future<void> setNewRoutePath(GetNavConfig configuration) async {
    _restoreShellTabBeforePop(targetRoute: configuration.locationString);
    final previousRouteIndex = history.lastIndexWhere(
      (entry) => entry.locationString == configuration.locationString,
    );
    if (previousRouteIndex >= 0 && previousRouteIndex < history.length - 1) {
      await backUntil(configuration.locationString, popMode: PopMode.History);
      return;
    }

    await super.setNewRoutePath(configuration);
  }

  void _restoreShellTabBeforePop({String? targetRoute}) {
    if (history.isEmpty ||
        history.last.locationString == targetRoute ||
        !Get.isRegistered<BottomNavController>()) {
      return;
    }

    final controller = Get.find<BottomNavController>();
    switch (history.last.locationString) {
      case AppRoutes.cart:
        controller.leaveCartRoute();
        break;
      case AppRoutes.account:
        controller.leaveAccountRoute();
        break;
    }
  }

  Future<T> offAllNamed<T>(String page, {dynamic arguments}) async {
    history.clear();
    await _resetBrowserHistory();
    return toNamed<T>(page, arguments: arguments);
  }

  Future<void> resetStackTo(String page, {dynamic arguments}) async {
    history.clear();
    await _resetBrowserHistory();

    final decoder = Get.routeTree.matchRoute(page, arguments: arguments);
    decoder.replaceArguments(arguments);
    if (decoder.route == null) {
      throw StateError('No route is registered for "$page".');
    }

    await pushHistory(
      GetNavConfig(
        currentTreeBranch: decoder.treeBranch,
        location: page,
        state: null,
      ),
    );
  }

  Future<void> _resetBrowserHistory() async {
    if (kIsWeb) await SystemNavigator.selectSingleEntryHistory();
  }
}
