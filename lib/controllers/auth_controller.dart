import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../view/auth/login_screen.dart';
import '../view/auth/register_screen.dart';
import '../view/navigation/app_navigation.dart';

class AuthController extends GetxController {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void openLogin() {
    void onLoginSuccess() => _completeAuthentication(() {}, routeCount: 2);
    void onRegisterSuccess() => _completeAuthentication(() {}, routeCount: 3);
    AppRoutes.to<void>(
      route: AppRoutes.login,
      arguments: {
        'onLoginSuccess': onLoginSuccess,
        'onRegisterSuccess': onRegisterSuccess,
      },
      mobileBuilder: () => LoginScreen(
        onLoginSuccess: onLoginSuccess,
        onRegisterSuccess: onRegisterSuccess,
      ),
    );
  }

  void openRegister() {
    void onRegisterSuccess() => _completeAuthentication(() {}, routeCount: 2);
    AppRoutes.to<void>(
      route: AppRoutes.register,
      arguments: {'onRegisterSuccess': onRegisterSuccess},
      mobileBuilder: () => RegisterScreen(onRegisterSuccess: onRegisterSuccess),
    );
  }

  void logout() {
    _isAuthenticated = false;
    update();
  }

  void completeDemoAuthentication() {
    _isAuthenticated = true;
    update();
  }

  void requireAuthentication({required VoidCallback onAuthenticated}) {
    if (_isAuthenticated) {
      onAuthenticated();
      return;
    }

    void onLoginSuccess() =>
        _completeAuthentication(onAuthenticated, routeCount: 2);
    void onRegisterSuccess() =>
        _completeAuthentication(onAuthenticated, routeCount: 3);
    AppRoutes.to<void>(
      route: AppRoutes.login,
      arguments: {
        'onLoginSuccess': onLoginSuccess,
        'onRegisterSuccess': onRegisterSuccess,
      },
      mobileBuilder: () => LoginScreen(
        onLoginSuccess: onLoginSuccess,
        onRegisterSuccess: onRegisterSuccess,
      ),
    );
  }

  void _completeAuthentication(
    VoidCallback onAuthenticated, {
    required int routeCount,
  }) {
    _isAuthenticated = true;
    update();
    for (var index = 0; index < routeCount; index++) {
      Get.back<void>();
    }
    onAuthenticated();
  }
}
