import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

enum AppBadgeVariant { discount, inStock, outOfStock, codAvailable }

class AppStatusBadge extends StatelessWidget {
  const AppStatusBadge({super.key, required this.label, required this.variant});

  final String label;
  final AppBadgeVariant variant;

  Color get _backgroundColor => switch (variant) {
    AppBadgeVariant.discount => AppColors.softPeach,
    AppBadgeVariant.inStock => AppColors.successGreen.withValues(alpha: 0.08),
    AppBadgeVariant.outOfStock => AppColors.dangerRed.withValues(alpha: 0.08),
    AppBadgeVariant.codAvailable => AppColors.codPurple.withValues(alpha: 0.08),
  };

  Color get _foregroundColor => switch (variant) {
    AppBadgeVariant.discount => AppColors.primary,
    AppBadgeVariant.inStock => AppColors.successGreen,
    AppBadgeVariant.outOfStock => AppColors.dangerRed,
    AppBadgeVariant.codAvailable => AppColors.codPurple,
  };

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Text(
          label,
          style: AppTextStyles.badge.copyWith(color: _foregroundColor),
        ),
      ),
    );
  }
}
