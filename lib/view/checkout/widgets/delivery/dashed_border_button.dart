import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/assets_path.dart';
import 'dashed_border_painter.dart';

class DashedBorderButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const DashedBorderButton({
    super.key,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 36,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: CustomPaint(
          painter: const DashedBorderPainter(
            color: AppColors.primary,
            radius: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AssetsPath.checkoutAdd, width: 16, height: 16),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.badge.copyWith(
                  fontSize: 13,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
