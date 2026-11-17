import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../navigation/web_site_header.dart';
import 'widgets/guest_account_view.dart';
import 'widgets/logged_in_account_view.dart';
import 'widgets/web_account_views.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.showWebHeader = true});

  final bool showWebHeader;

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1100;

        return GetBuilder<AuthController>(
          builder: (auth) {
            if (!isDesktop) {
              return auth.isAuthenticated
                  ? const LoggedInAccountView()
                  : GuestAccountView(authController: authController);
            }

            final accountView = auth.isAuthenticated
                ? const WebLoggedInAccountView()
                : WebGuestAccountView(authController: authController);

            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Column(
                children: [
                  if (kIsWeb && showWebHeader)
                    const WebSiteHeader(isHome: false),
                  Expanded(child: accountView),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
