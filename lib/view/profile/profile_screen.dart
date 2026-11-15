import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import 'widgets/guest_account_view.dart';
import 'widgets/logged_in_account_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return GetBuilder<AuthController>(
      builder: (auth) => auth.isAuthenticated
          ? const LoggedInAccountView()
          : GuestAccountView(authController: authController),
    );
  }
}
