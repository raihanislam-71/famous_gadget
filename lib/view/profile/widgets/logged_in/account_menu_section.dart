import 'package:famous_gadget/view/navigation/app_navigation.dart';
import 'package:flutter/material.dart';

import '../../../utils/assets_path.dart';
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
          onTap: () => AppRoutes.toNamed<void>(route: AppRoutes.editProfile),
        ),
        AccountMenuItem(
          title: 'Change Password',
          iconPath: AssetsPath.accountLock,
          onTap: () => AppRoutes.toNamed<void>(route: AppRoutes.changePassword),
        ),
        AccountMenuItem(
          title: 'My Addresses',
          iconPath: AssetsPath.accountMapPin,
          onTap: () => AppRoutes.toNamed<void>(route: AppRoutes.addresses),
        ),
        AccountMenuItem(
          title: 'My Orders',
          iconPath: AssetsPath.accountPackage,
          onTap: () => AppRoutes.toNamed<void>(
            route: AppRoutes.orders,
            arguments: const {'isPreview': true},
          ),
        ),
        AccountMenuItem(
          title: 'My Wishlist',
          iconPath: AssetsPath.accountHeart,
          isLast: true,
          onTap: () => AppRoutes.toNamed<void>(route: AppRoutes.wishlist),
        ),
      ],
    );
  }
}
