import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:famous_gadget/view/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class OrderSuccessTitle extends StatelessWidget {
  final bool isPreview;

  const OrderSuccessTitle({super.key, required this.isPreview});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Order Placed Successfully!',
          textAlign: TextAlign.center,
          style: AppTextStyles.h2.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.surface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isPreview
              ? 'Preview only — your order is not submitted until checkout API is connected.'
              : 'We will call you shortly to confirm your delivery address.',
          textAlign: TextAlign.center,
          style: AppTextStyles.body.copyWith(
            fontSize: 14,
            height: 1.4,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }
}
