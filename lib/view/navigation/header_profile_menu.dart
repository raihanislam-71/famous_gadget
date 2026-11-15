import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import 'app_navigation.dart';

class HeaderProfileMenu extends StatelessWidget {
  const HeaderProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_ProfileMenuAction>(
      tooltip: 'Account menu',
      icon: const Icon(Icons.person_outline),
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Theme.of(context).colorScheme.surface,
      onSelected: _handleProfileAction,
      itemBuilder: (context) => [
        if (Get.find<AuthController>().isAuthenticated) ...[
          const PopupMenuItem(
            value: _ProfileMenuAction.account,
            child: _ProfileMenuLabel(
              icon: Icons.person_outline,
              label: 'My Account',
            ),
          ),
          const PopupMenuItem(
            value: _ProfileMenuAction.orders,
            child: _ProfileMenuLabel(
              icon: Icons.inventory_2_outlined,
              label: 'My Orders',
            ),
          ),
          const PopupMenuItem(
            value: _ProfileMenuAction.addresses,
            child: _ProfileMenuLabel(
              icon: Icons.location_on_outlined,
              label: 'Saved Addresses',
            ),
          ),
          const PopupMenuItem(
            value: _ProfileMenuAction.wishlist,
            child: _ProfileMenuLabel(
              icon: Icons.favorite_border,
              label: 'Wishlist',
            ),
          ),
          const PopupMenuItem(
            value: _ProfileMenuAction.logout,
            child: _ProfileMenuLabel(icon: Icons.logout, label: 'Log out'),
          ),
        ] else ...[
          const PopupMenuItem(
            value: _ProfileMenuAction.account,
            child: _ProfileMenuLabel(
              icon: Icons.person_outline,
              label: 'My Account',
            ),
          ),
          const PopupMenuItem(
            value: _ProfileMenuAction.login,
            child: _ProfileMenuLabel(icon: Icons.login, label: 'Log in'),
          ),
          const PopupMenuItem(
            value: _ProfileMenuAction.register,
            child: _ProfileMenuLabel(
              icon: Icons.person_add_alt,
              label: 'Create account',
            ),
          ),
          const PopupMenuItem(
            value: _ProfileMenuAction.orders,
            child: _ProfileMenuLabel(
              icon: Icons.inventory_2_outlined,
              label: 'My Orders',
            ),
          ),
        ],
      ],
    );
  }

  void _handleProfileAction(_ProfileMenuAction action) {
    final auth = Get.find<AuthController>();
    switch (action) {
      case _ProfileMenuAction.account:
        AppRoutes.to<void>(
          route: AppRoutes.account,
          mobileBuilder: () => const SizedBox.shrink(),
        );
        break;
      case _ProfileMenuAction.orders:
        auth.requireAuthentication(
          onAuthenticated: () => AppRoutes.to<void>(
            route: AppRoutes.orders,
            arguments: const {'isPreview': true},
            mobileBuilder: () => const SizedBox.shrink(),
          ),
        );
        break;
      case _ProfileMenuAction.addresses:
        auth.requireAuthentication(
          onAuthenticated: () => AppRoutes.to<void>(
            route: AppRoutes.addresses,
            mobileBuilder: () => const SizedBox.shrink(),
          ),
        );
        break;
      case _ProfileMenuAction.wishlist:
        auth.requireAuthentication(
          onAuthenticated: () => AppRoutes.to<void>(
            route: AppRoutes.wishlist,
            mobileBuilder: () => const SizedBox.shrink(),
          ),
        );
        break;
      case _ProfileMenuAction.login:
        auth.openLogin();
        break;
      case _ProfileMenuAction.register:
        auth.openRegister();
        break;
      case _ProfileMenuAction.logout:
        auth.logout();
        break;
    }
  }
}

enum _ProfileMenuAction {
  account,
  orders,
  addresses,
  wishlist,
  login,
  register,
  logout,
}

class _ProfileMenuLabel extends StatelessWidget {
  const _ProfileMenuLabel({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Icon(icon, size: 18), const SizedBox(width: 12), Text(label)],
    );
  }
}
