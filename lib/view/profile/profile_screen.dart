import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'my_addresses_screen.dart';
import '../wishlist/wishlist_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navyDark,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text('Profile', style: AppTextStyles.h2.copyWith(fontSize: 20)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Material(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            child: ListTile(
              onTap: () => Get.to<void>(() => const MyAddressesScreen()),
              leading: const Icon(
                Icons.location_on_outlined,
                color: AppColors.primary,
              ),
              title: Text(
                'My Addresses',
                style: AppTextStyles.uiSemibold.copyWith(fontSize: 15),
              ),
              subtitle: const Text(
                'Manage your delivery addresses',
                style: AppTextStyles.caption,
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: AppColors.secondaryText,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Material(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            child: ListTile(
              onTap: () => Get.to<void>(() => const WishlistScreen()),
              leading: const Icon(
                Icons.favorite_border,
                color: AppColors.primary,
              ),
              title: Text(
                'My Wishlist',
                style: AppTextStyles.uiSemibold.copyWith(fontSize: 15),
              ),
              subtitle: const Text(
                'View your saved products',
                style: AppTextStyles.caption,
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: AppColors.secondaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}