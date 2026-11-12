import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/theme_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

AppBar profileAppBar(BuildContext context, String title) {
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
