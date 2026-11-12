import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/profile_controller.dart';
import '../../checkout/my_orders_screen.dart';
import '../../navigation/app_navigation.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/assets_path.dart';
import '../../wishlist/wishlist_screen.dart';
import '../change_password_screen.dart';
import '../edit_profile_screen.dart';
import '../my_addresses_screen.dart';
import 'profile_app_bar.dart';
import 'profile_menu_widgets.dart';

class LoggedInAccountView extends StatelessWidget {
  const LoggedInAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: profileAppBar(context, 'My Account'),
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
                  AccountMenuGroup(
                    children: [
                      AccountMenuItem(
                        title: 'Edit Profile',
                        iconPath: AssetsPath.accountGuestUser,
                        onTap: () => AppRoutes.to<void>(
                          route: AppRoutes.editProfile,
                          mobileBuilder: () => const EditProfileScreen(),
                        ),
                      ),
                      AccountMenuItem(
                        title: 'Change Password',
                        iconPath: AssetsPath.accountLock,
                        onTap: () => AppRoutes.to<void>(
                          route: AppRoutes.changePassword,
                          mobileBuilder: () => const ChangePasswordScreen(),
                        ),
                      ),
                      AccountMenuItem(
                        title: 'My Addresses',
                        iconPath: AssetsPath.accountMapPin,
                        onTap: () => AppRoutes.to<void>(
                          route: AppRoutes.addresses,
                          mobileBuilder: () => const MyAddressesScreen(),
                        ),
                      ),
                      AccountMenuItem(
                        title: 'My Orders',
                        iconPath: AssetsPath.accountPackage,
                        onTap: () => AppRoutes.to<void>(
                          route: AppRoutes.orders,
                          arguments: const {'isPreview': true},
                          mobileBuilder: () =>
                              const MyOrdersScreen(isPreview: true),
                        ),
                      ),
                      AccountMenuItem(
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
                  AccountMenuGroup(
                    children: [
                      AccountMenuItem(
                        title: 'App Settings',
                        iconPath: AssetsPath.accountSettings,
                        onTap: () => _showDemoNotice('App Settings'),
                      ),
                      AccountMenuItem(
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
