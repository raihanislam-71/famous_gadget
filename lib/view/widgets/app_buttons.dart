import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.height = 52,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(height / 2),
      child: Ink(
        height: height,
        decoration: BoxDecoration(
          color: isEnabled ? null : AppColors.disabledBackground,
          gradient: isEnabled
              ? const LinearGradient(
                  colors: [AppColors.primary, AppColors.orangeHover],
                )
              : null,
          borderRadius: BorderRadius.circular(height / 2),
        ),
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(height / 2),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    label,
                    style: AppTextStyles.button.copyWith(
                      color: isEnabled
                          ? Colors.white
                          : AppColors.disabledForeground,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class AppOutlineButton extends StatelessWidget {
  const AppOutlineButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        shape: const StadiumBorder(),
        textStyle: AppTextStyles.badge,
      ),
      child: Text(label),
    );
  }
}
