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
import '../../widgets/app_buttons.dart';
import '../edit_profile_screen.dart';
import '../my_addresses_screen.dart';
import '../../wishlist/wishlist_screen.dart';
import 'guest_account_view.dart';
import 'logged_in/account_menu_section.dart';
import 'logged_in/logout_button_card.dart';
import 'logged_in/settings_menu_section.dart';

class WebLoggedInAccountView extends StatelessWidget {
  const WebLoggedInAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profile) => LayoutBuilder(
        builder: (context, constraints) {
          final contentWidth = constraints.maxWidth > 1120
              ? 1120.0
              : constraints.maxWidth;
          final useColumns = constraints.maxWidth >= 860;
          final horizontalPadding = useColumns ? 32.0 : 20.0;

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              32,
              horizontalPadding,
              40,
            ),
            child: Center(
              child: SizedBox(
                width: contentWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Account',
                      style: AppTextStyles.h1.copyWith(fontSize: 34),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Manage your profile, orders, and account preferences.',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _WebProfileSummary(profile: profile),
                    const SizedBox(height: 24),
                    if (useColumns)
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: _WebMenuCard(
                              title: 'Account',
                              child: AccountMenuSection(),
                            ),
                          ),
                          SizedBox(width: 24),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                _WebMenuCard(
                                  title: 'Settings',
                                  child: SettingsMenuSection(),
                                ),
                                SizedBox(height: 16),
                                LogoutButtonCard(),
                              ],
                            ),
                          ),
                        ],
                      )
                    else ...[
                      const _WebMenuCard(
                        title: 'Account',
                        child: AccountMenuSection(),
                      ),
                      const SizedBox(height: 16),
                      const _WebMenuCard(
                        title: 'Settings',
                        child: SettingsMenuSection(),
                      ),
                      const SizedBox(height: 16),
                      const LogoutButtonCard(),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class WebGuestAccountView extends StatelessWidget {
  const WebGuestAccountView({super.key, required this.authController});

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final contentWidth = constraints.maxWidth > 860
            ? 860.0
            : constraints.maxWidth;
        final useColumns = constraints.maxWidth >= 760;
        final horizontalPadding = useColumns ? 32.0 : 20.0;

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            32,
            horizontalPadding,
            40,
          ),
          child: Center(
            child: SizedBox(
              width: contentWidth,
              child: Column(
                children: [
                  Text(
                    'My Profile',
                    style: AppTextStyles.h1.copyWith(fontSize: 34),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Sign in to manage your orders, wishlist, and delivery details.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(useColumns ? 36 : 24),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 88,
                          height: 88,
                          decoration: const BoxDecoration(
                            color: AppColors.pageBackground,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            AssetsPath.accountGuestUser,
                            width: 44,
                            height: 44,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Welcome, Guest',
                          style: AppTextStyles.h2.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Unlock your full gadget account experience.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.secondaryText,
                          ),
                        ),
                        const SizedBox(height: 22),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 460),
                          child: Row(
                            children: [
                              Expanded(
                                child: AppPrimaryButton(
                                  label: 'Login',
                                  height: 46,
                                  onPressed: authController.openLogin,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: authController.openRegister,
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppColors.primary,
                                    side: const BorderSide(
                                      color: AppColors.primary,
                                    ),
                                    minimumSize: const Size.fromHeight(46),
                                    shape: const StadiumBorder(),
                                  ),
                                  child: const Text('Register'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (useColumns)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GuestLockedItem(
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
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GuestLockedItem(
                            title: 'Wishlist',
                            subtitle: 'View saved items to buy later',
                            onTap: () => _requireLogin(
                              () => AppRoutes.to<void>(
                                route: AppRoutes.wishlist,
                                mobileBuilder: () => const WishlistScreen(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GuestLockedItem(
                            title: 'Saved Addresses',
                            subtitle: 'Manage Dhaka delivery zones',
                            onTap: () => _requireLogin(
                              () => AppRoutes.to<void>(
                                route: AppRoutes.addresses,
                                mobileBuilder: () => const MyAddressesScreen(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
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
                      ],
                    ),
                  const SizedBox(height: 16),
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
          ),
        );
      },
    );
  }

  void _requireLogin(VoidCallback onAuthenticated) {
    authController.requireAuthentication(onAuthenticated: onAuthenticated);
  }
}

class _WebProfileSummary extends StatelessWidget {
  const _WebProfileSummary({required this.profile});

  final ProfileController profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              profile.initials,
              style: AppTextStyles.h2.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.fullName,
                  style: AppTextStyles.h2.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${profile.email} • ${profile.city}, BD',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.phone,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          OutlinedButton.icon(
            onPressed: () => AppRoutes.to<void>(
              route: AppRoutes.editProfile,
              mobileBuilder: () => const EditProfileScreen(),
            ),
            icon: const Icon(Icons.edit_outlined, size: 18),
            label: const Text('Edit Profile'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              shape: const StadiumBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

class _WebMenuCard extends StatelessWidget {
  const _WebMenuCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
            child: Text(
              title,
              style: AppTextStyles.uiSemibold.copyWith(fontSize: 16),
            ),
          ),
          const Divider(height: 1),
          child,
        ],
      ),
    );
  }
}
