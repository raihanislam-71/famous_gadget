import 'package:bdcalling_class/controllers/bottom_nav_controller.dart';
import 'package:bdcalling_class/controllers/cart_controller.dart';
import 'package:bdcalling_class/view/cart/cart_screen.dart';
import 'package:bdcalling_class/view/category/category_screen.dart';
import 'package:bdcalling_class/view/home/home_screen.dart';
import 'package:bdcalling_class/view/profile/profile_screen.dart';
import 'package:bdcalling_class/view/utils/app_colors.dart';
import 'package:bdcalling_class/view/utils/app_text_styles.dart';
import 'package:bdcalling_class/view/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../home/web_home_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  final BottomNavController _bottomNavController =
      Get.find<BottomNavController>();

  final List<Widget> _screens = const [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return const WebHomeScreen();

    return GetBuilder<BottomNavController>(
      builder: (_) {
        return Scaffold(
          extendBody: true,
          backgroundColor: Colors.transparent,
          body: _screens[_bottomNavController.selectedIndex],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              height: 68,
              decoration: BoxDecoration(
                color: AppColors.navyDark,
                borderRadius: BorderRadius.circular(34),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNavItem(0, AssetsPath.navHome, 'Home'),
                    _buildNavItem(1, AssetsPath.navGrid, 'Category'),
                    GetBuilder<CartController>(
                      builder: (cart) => _buildNavItem(
                        2,
                        AssetsPath.navCart,
                        'Cart',
                        badge: cart.totalItemCount,
                      ),
                    ),
                    _buildNavItem(3, AssetsPath.navUser, 'Account'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
    int index,
    String iconPath,
    String label, {
    int badge = 0,
  }) {
    final isSelected = _bottomNavController.selectedIndex == index;
    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: InkWell(
        onTap: () => _bottomNavController.changeIndex(index),
        borderRadius: BorderRadius.circular(22),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 44,
          padding: EdgeInsets.symmetric(
            horizontal: isSelected ? 16 : 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: 8),
                Text(
                  label,
                  style: AppTextStyles.button.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
              if (badge > 0)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    '$badge',
                    style: AppTextStyles.caption.copyWith(color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
