import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../view/auth/login_screen.dart';
import '../view/auth/register_screen.dart';

class AuthController extends GetxController {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void openLogin() {
    Get.to<void>(
      () => LoginScreen(
        onLoginSuccess: () => _completeAuthentication(() {}, routeCount: 2),
        onRegisterSuccess: () => _completeAuthentication(() {}, routeCount: 3),
      ),
    );
  }

  void openRegister() {
    Get.to<void>(
      () => RegisterScreen(
        onRegisterSuccess: () => _completeAuthentication(() {}, routeCount: 2),
      ),
    );
  }

  void logout() {
    _isAuthenticated = false;
    update();
  }

  void requireAuthentication({required VoidCallback onAuthenticated}) {
    if (_isAuthenticated) {
      onAuthenticated();
      return;
    }

    Get.to<void>(
      () => LoginScreen(
        onLoginSuccess: () =>
            _completeAuthentication(onAuthenticated, routeCount: 2),
        onRegisterSuccess: () =>
            _completeAuthentication(onAuthenticated, routeCount: 3),
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
