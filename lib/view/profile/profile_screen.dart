import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../controllers/theme_controller.dart';
import '../checkout/my_orders_screen.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/assets_path.dart';
import '../wishlist/wishlist_screen.dart';
import 'change_password_screen.dart';
import 'edit_profile_screen.dart';
import 'my_addresses_screen.dart';
import '../navigation/app_navigation.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return GetBuilder<AuthController>(
      builder: (auth) => auth.isAuthenticated
          ? const _LoggedInAccount()
          : _GuestAccount(authController: authController),
    );
  }
}

class _GuestAccount extends StatelessWidget {
  const _GuestAccount({required this.authController});

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _accountAppBar(context, 'My Profile'),
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
                      child: _GradientButton(
                        label: 'Login',
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
                _GuestLockedItem(
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
                _GuestLockedItem(
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
                _GuestLockedItem(
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

class _GuestLockedItem extends StatelessWidget {
  const _GuestLockedItem({
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

class _LoggedInAccount extends StatelessWidget {
  const _LoggedInAccount();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _accountAppBar(context, 'My Account'),
      body: GetBuilder<ProfileController>(
        builder: (profile) => ListView(
          padding: const EdgeInsets.only(bottom: 104),
          children: [
            Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      profile.initials,
                      style: AppTextStyles.h2.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.fullName,
                          style: AppTextStyles.h2.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${profile.email} • ${profile.city}, BD',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.caption,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          profile.phone,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: [
                  _AccountMenuGroup(
                    children: [
                      _AccountMenuItem(
                        title: 'Edit Profile',
                        iconPath: AssetsPath.accountGuestUser,
                        onTap: () => AppRoutes.to<void>(
                          route: AppRoutes.editProfile,
                          mobileBuilder: () => const EditProfileScreen(),
                        ),
                      ),
                      _AccountMenuItem(
                        title: 'Change Password',
                        iconPath: AssetsPath.accountLock,
                        onTap: () => AppRoutes.to<void>(
                          route: AppRoutes.changePassword,
                          mobileBuilder: () => const ChangePasswordScreen(),
                        ),
                      ),
                      _AccountMenuItem(
                        title: 'My Addresses',
                        iconPath: AssetsPath.accountMapPin,
                        onTap: () => AppRoutes.to<void>(
                          route: AppRoutes.addresses,
                          mobileBuilder: () => const MyAddressesScreen(),
                        ),
                      ),
                      _AccountMenuItem(
                        title: 'My Orders',
                        iconPath: AssetsPath.accountPackage,
                        onTap: () => AppRoutes.to<void>(
                          route: AppRoutes.orders,
                          arguments: const {'isPreview': true},
                          mobileBuilder: () =>
                              const MyOrdersScreen(isPreview: true),
                        ),
                      ),
                      _AccountMenuItem(
                        title: 'My Wishlist',
                        iconPath: AssetsPath.accountHeart,
                        isLast: true,
                        onTap: () => AppRoutes.to<void>(
                          route: AppRoutes.wishlist,
                          mobileBuilder: () => const WishlistScreen(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _AccountMenuGroup(
                    children: [
                      _AccountMenuItem(
                        title: 'App Settings',
                        iconPath: AssetsPath.accountSettings,
                        onTap: () => _showDemoNotice('App Settings'),
                      ),
                      _AccountMenuItem(
                        title: 'Help & Support',
                        iconPath: AssetsPath.accountHelp,
                        isLast: true,
                        onTap: () => _showDemoNotice('Help & Support'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Material(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      onTap: _confirmLogout,
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AssetsPath.accountLogout,
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Logout',
                              style: AppTextStyles.uiSemibold.copyWith(
                                fontSize: 15,
                                color: AppColors.dangerRed,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmLogout() async {
    final shouldLogout = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
    if (shouldLogout == true) Get.find<AuthController>().logout();
  }

  void _showDemoNotice(String feature) {
    Get.showSnackbar(
      GetSnackBar(
        message: '$feature is not connected in demo mode.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class _AccountMenuGroup extends StatelessWidget {
  const _AccountMenuGroup({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: Column(children: children),
    );
  }
}

class _AccountMenuItem extends StatelessWidget {
  const _AccountMenuItem({
    required this.title,
    required this.iconPath,
    required this.onTap,
    this.isLast = false,
  });

  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : const Border(bottom: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          children: [
            SvgPicture.asset(iconPath, width: 20, height: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.uiSemibold.copyWith(fontSize: 15),
              ),
            ),
            SvgPicture.asset(AssetsPath.accountChevron, width: 16, height: 16),
          ],
        ),
      ),
    );
  }
}

AppBar _accountAppBar(BuildContext context, String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Theme.of(context).colorScheme.surface,
    foregroundColor: Theme.of(context).colorScheme.onSurface,
    elevation: 0,
    scrolledUnderElevation: 0,
    shape: const Border(bottom: BorderSide(color: AppColors.border)),
    toolbarHeight: 60,
    titleSpacing: 16,
    title: Text(
      title,
      style: AppTextStyles.h2.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
    actions: [
      GetBuilder<ThemeController>(
        builder: (controller) => IconButton(
          tooltip: controller.isDarkMode
              ? 'Switch to light mode'
              : 'Switch to dark mode',
          onPressed: controller.toggleTheme,
          icon: Icon(
            controller.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          ),
        ),
      ),
    ],
  );
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.orangeHover],
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.surface,
            shadowColor: Colors.transparent,
            shape: const StadiumBorder(),
            textStyle: AppTextStyles.button.copyWith(fontSize: 14),
          ),
          child: Text(label),
        ),
      ),
    );
  }
}
