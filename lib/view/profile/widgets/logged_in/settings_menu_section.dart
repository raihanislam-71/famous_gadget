import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/assets_path.dart';
import '../profile_menu_widgets.dart';

class SettingsMenuSection extends StatelessWidget {
  const SettingsMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AccountMenuGroup(
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
    );
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
