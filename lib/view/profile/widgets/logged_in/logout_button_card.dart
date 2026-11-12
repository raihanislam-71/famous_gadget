import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/assets_path.dart';

class LogoutButtonCard extends StatelessWidget {
  const LogoutButtonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => _confirmLogout(context),
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
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
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
}
