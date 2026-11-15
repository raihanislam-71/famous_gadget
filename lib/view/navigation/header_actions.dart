import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/theme_controller.dart';
import 'app_navigation.dart';
import 'header_icon_button.dart';
import 'header_profile_menu.dart';

class HeaderActions extends StatelessWidget {
  const HeaderActions({
    super.key,
    required this.foreground,
    required this.showWishlist,
  });

  final Color foreground;
  final bool showWishlist;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showWishlist)
          HeaderIconButton(
            tooltip: 'Wishlist',
            icon: Icons.favorite_border,
            onPressed: () => AppRoutes.to<void>(
              route: AppRoutes.wishlist,
              mobileBuilder: () => const SizedBox.shrink(),
            ),
          ),
        GetBuilder<CartController>(
          builder: (cart) => HeaderIconButton(
            tooltip: 'Cart',
            icon: Icons.shopping_cart_outlined,
            badge: cart.totalItemCount,
            onPressed: () => AppRoutes.to<void>(
              route: AppRoutes.cart,
              mobileBuilder: () => const SizedBox.shrink(),
            ),
          ),
        ),
        const HeaderProfileMenu(),
        GetBuilder<ThemeController>(
          builder: (controller) => IconButton(
            constraints: const BoxConstraints.tightFor(width: 40, height: 40),
            padding: EdgeInsets.zero,
            tooltip: controller.isDarkMode
                ? 'Switch to light mode'
                : 'Switch to dark mode',
            onPressed: controller.toggleTheme,
            icon: Icon(
              controller.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: foreground,
            ),
          ),
        ),
      ],
    );
  }
}
