import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

enum AppMessageVariant { processing, success }

class AppStatusMessage extends StatelessWidget {
  const AppStatusMessage({
    super.key,
    required this.message,
    required this.variant,
  });

  final String message;
  final AppMessageVariant variant;

  Color get _color => switch (variant) {
    AppMessageVariant.processing => AppColors.amber,
    AppMessageVariant.success => AppColors.successGreen,
  };

  @override
  Widget build(BuildContext context) {
    final color = _color;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        message,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
