import 'package:famous_gadget/view/checkout/my_orders_screen.dart';
import 'package:famous_gadget/view/navigation/app_navigation.dart';
import 'package:famous_gadget/view/wishlist/wishlist_screen.dart';
import 'package:flutter/material.dart';
import '../../../utils/assets_path.dart';
import '../../change_password_screen.dart';
import '../../edit_profile_screen.dart';
import '../../my_addresses_screen.dart';
import '../profile_menu_widgets.dart';

class AccountMenuSection extends StatelessWidget {
  const AccountMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AccountMenuGroup(
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
            mobileBuilder: () => const MyOrdersScreen(isPreview: true),
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
    );
  }
}
