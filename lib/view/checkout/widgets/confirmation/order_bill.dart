import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/assets_path.dart';

class OrderBill extends StatelessWidget {
  const OrderBill({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildBillRow(context, 'Subtotal', '৳26,498'),
          const SizedBox(height: 8),
          _buildBillRow(context, 'Shipping Fee', '৳120'),
          const SizedBox(height: 8),
          _buildBillRow(
            context,
            'Promo Discount',
            '-৳500',
            valueColor: AppColors.successGreen,
          ),
          const SizedBox(height: 8),
          SvgPicture.asset(AssetsPath.checkoutBillDivider),
          const SizedBox(height: 8),
          _buildBillRow(
            context,
            'Total Amount',
            '৳26,118',
            isTotal: true,
            valueColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildBillRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTextStyles.uiSemibold.copyWith(fontSize: 16)
              : AppTextStyles.body.copyWith(
                  fontSize: 13,
                  height: 1,
                  color: AppColors.secondaryText,
                ),
        ),
        Text(
          value,
          style: isTotal
              ? AppTextStyles.h2.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: valueColor,
                )
              : AppTextStyles.body.copyWith(
                  fontSize: 13,
                  height: 1,
                  color: valueColor ?? Theme.of(context).colorScheme.onSurface,
                ),
        ),
      ],
    );
  }
}
