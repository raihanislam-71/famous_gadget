import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:famous_gadget/view/utils/app_text_styles.dart';
import 'package:famous_gadget/view/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckoutStepIndicator extends StatelessWidget {
  final int activeStep;

  const CheckoutStepIndicator({super.key, required this.activeStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStep(context, 1, 'Delivery'),
          _buildDivider(afterStep: 1),
          _buildStep(context, 2, 'Confirm'),
          _buildDivider(afterStep: 2),
          _buildStep(context, 3, 'Done'),
        ],
      ),
    );
  }

  Widget _buildDivider({required int afterStep}) => SvgPicture.asset(
    afterStep == 1
        ? AssetsPath.checkoutConfirmDividerActive
        : AssetsPath.checkoutStepDivider,
    width: 32,
    height: 2,
  );

  Widget _buildStep(BuildContext context, int step, String label) {
    final active = step == activeStep;
    final completed = step < activeStep;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active || completed ? AppColors.primary : AppColors.border,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$step',
            style: AppTextStyles.badge.copyWith(
              fontSize: 12,
              color: active || completed
                  ? AppColors.surface
                  : AppColors.secondaryText,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTextStyles.badge.copyWith(
            fontSize: 13,
            color: active ? AppColors.primary : AppColors.secondaryText,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
