import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/theme_controller.dart';
import '../utils/app_colors.dart';
import '../utils/assets_path.dart';
import 'app_navigation.dart';

class WebSiteHeader extends StatelessWidget {
  const WebSiteHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final foreground = theme.colorScheme.onSurface;

    return Column(
      children: [
        Container(
          width: double.infinity,
          color: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Gadgets you love. Cash on Delivery BD.',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  if (MediaQuery.sizeOf(context).width > 650)
                    const Text(
                      'Track Order     Store Locator     Support: 09612-FAMOUS',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                ],
              ),
            ),
          ),
        ),
        Container(
          color: theme.colorScheme.surface,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxWidth < 850;
                  final veryCompact = constraints.maxWidth < 440;
                  final logo = _buildLogo(width: veryCompact ? 112 : 156);
                  final search = _buildSearch(context);
                  final actions = _buildActions(
                    context,
                    foreground,
                    showWishlist: !veryCompact,
                  );

                  if (compact) {
                    return Column(
                      children: [
                        Row(children: [logo, const Spacer(), actions]),
                        const SizedBox(height: 10),
                        search,
                        const SizedBox(height: 10),
                        _buildLinks(context, foreground),
                      ],
                    );
                  }

                  return Row(
                    children: [
                      logo,
                      const SizedBox(width: 32),
                      Expanded(child: search),
                      const SizedBox(width: 24),
                      _buildLinks(context, foreground),
                      const SizedBox(width: 12),
                      actions,
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        if (isDark) const Divider(height: 1, color: AppColors.border),
      ],
    );
  }

  Widget _buildLogo({double width = 156}) {
    return Semantics(
      button: true,
      label: 'Famous Gadget home',
      child: InkWell(
        onTap: () => AppRoutes.to<void>(
          route: AppRoutes.home,
          mobileBuilder: () => const SizedBox.shrink(),
        ),
        child: SizedBox(
          width: width,
          height: 40,
          child: Row(
            children: [
              Image.asset(AssetsPath.appLogo, width: 42, fit: BoxFit.contain),
              const SizedBox(width: 6),
              Expanded(
                child: Image.asset(
                  AssetsPath.appName,
                  fit: BoxFit.contain,
                  color: Get.theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: (_) => AppRoutes.to<void>(
          route: AppRoutes.search,
          mobileBuilder: () => const SizedBox.shrink(),
        ),
        decoration: InputDecoration(
          hintText: 'Search authentic smart watches, earbuds, gimbals...',
          prefixIcon: const Icon(Icons.search, size: 20),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(4),
            child: FilledButton(
              onPressed: () => AppRoutes.to<void>(
                route: AppRoutes.search,
                mobileBuilder: () => const SizedBox.shrink(),
              ),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                minimumSize: Size.zero,
              ),
              child: const Text('Search'),
            ),
          ),
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme.of(context).dividerColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
      ),
    );
  }

  Widget _buildLinks(BuildContext context, Color foreground) {
    return Wrap(
      spacing: 16,
      runSpacing: 4,
      alignment: WrapAlignment.center,
      children: [
        _HeaderLink(
          label: 'New Arrivals',
          onTap: () => _openProducts('New Arrivals'),
        ),
        _HeaderLink(label: 'Categories', onTap: _openCategories),
        _HeaderLink(
          label: 'Campaigns',
          onTap: () => _openProducts('Hot Deals'),
        ),
      ],
    );
  }

  Widget _buildActions(
    BuildContext context,
    Color foreground, {
    required bool showWishlist,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showWishlist)
          _HeaderIconButton(
            tooltip: 'Wishlist',
            icon: Icons.favorite_border,
            onPressed: () => AppRoutes.to<void>(
              route: AppRoutes.wishlist,
              mobileBuilder: () => const SizedBox.shrink(),
            ),
          ),
        GetBuilder<CartController>(
          builder: (cart) => _HeaderIconButton(
            tooltip: 'Cart',
            icon: Icons.shopping_cart_outlined,
            badge: cart.totalItemCount,
            onPressed: () => AppRoutes.to<void>(
              route: AppRoutes.cart,
              mobileBuilder: () => const SizedBox.shrink(),
            ),
          ),
        ),
        PopupMenuButton<_ProfileMenuAction>(
          tooltip: 'Account menu',
          icon: const Icon(Icons.person_outline),
          position: PopupMenuPosition.under,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
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
                child: _ProfileMenuLabel(
                  icon: Icons.logout,
                  label: 'Log out',
                ),
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
                child: _ProfileMenuLabel(
                  icon: Icons.login,
                  label: 'Log in',
                ),
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
        ),
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

  void _openCategories() {
    AppRoutes.to<void>(
      route: AppRoutes.categories,
      mobileBuilder: () => const SizedBox.shrink(),
    );
  }

  void _openProducts(String categoryName) {
    AppRoutes.to<void>(
      route: AppRoutes.products,
      arguments: {'categoryName': categoryName},
      mobileBuilder: () => const SizedBox.shrink(),
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
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 12),
        Text(label),
      ],
    );
  }
}

class _HeaderLink extends StatelessWidget {
  const _HeaderLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
    this.badge = 0,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;
  final int badge;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      constraints: const BoxConstraints.tightFor(width: 40, height: 40),
      padding: EdgeInsets.zero,
      icon: Badge(
        isLabelVisible: badge > 0,
        label: Text('$badge'),
        child: Icon(icon),
      ),
    );
  }
}
