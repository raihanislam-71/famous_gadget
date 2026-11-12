import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../checkout/my_orders_screen.dart';
import '../../navigation/app_navigation.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/assets_path.dart';
import '../../widgets/app_buttons.dart';
import '../my_addresses_screen.dart';
import '../../wishlist/wishlist_screen.dart';
import 'profile_app_bar.dart';

class GuestAccountView extends StatelessWidget {
  const GuestAccountView({super.key, required this.authController});

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: profileAppBar(context, 'My Profile'),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 104),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: AppColors.pageBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AssetsPath.accountGuestUser,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Welcome, Guest',
                  style: AppTextStyles.h2.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Login to unlock seamless gadget shopping',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption.copyWith(fontSize: 13),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AppPrimaryButton(
                        label: 'Login',
                        height: 44,
                        onPressed: authController.openLogin,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: authController.openRegister,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                          minimumSize: const Size.fromHeight(44),
                          shape: const StadiumBorder(),
                          textStyle: AppTextStyles.button.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        child: const Text('Register'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                GuestLockedItem(
                  title: 'My Orders',
                  subtitle: 'Track active & past shipments',
                  onTap: () => _requireLogin(
                    () => AppRoutes.to<void>(
                      route: AppRoutes.orders,
                      arguments: const {'isPreview': true},
                      mobileBuilder: () =>
                          const MyOrdersScreen(isPreview: true),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GuestLockedItem(
                  title: 'Wishlist',
                  subtitle: 'View saved items to buy later',
                  onTap: () => _requireLogin(
                    () => AppRoutes.to<void>(
                      route: AppRoutes.wishlist,
                      mobileBuilder: () => const WishlistScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GuestLockedItem(
                  title: 'Saved Addresses',
                  subtitle: 'Manage Dhaka delivery zones',
                  onTap: () => _requireLogin(
                    () => AppRoutes.to<void>(
                      route: AppRoutes.addresses,
                      mobileBuilder: () => const MyAddressesScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.softPeach,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '🔒 Account login is required to proceed with Cash on Delivery checkouts.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 12,
                      height: 1.3,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _requireLogin(VoidCallback onAuthenticated) {
    authController.requireAuthentication(onAuthenticated: onAuthenticated);
  }
}

class GuestLockedItem extends StatelessWidget {
  const GuestLockedItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              SvgPicture.asset(AssetsPath.accountLock, width: 20, height: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.uiSemibold.copyWith(
                        fontSize: 15,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.caption.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Text(
                'LOCKED',
                style: AppTextStyles.badge.copyWith(
                  fontSize: 11,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
