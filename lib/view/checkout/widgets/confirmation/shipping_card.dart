import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';

class ShippingCard extends StatelessWidget {
  const ShippingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: AppColors.primary, width: 1.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _buildRadio(true),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Express Delivery (Dhaka Only)',
                  style: AppTextStyles.badge.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  'Same day delivery inside Dhaka zones',
                  style: AppTextStyles.caption.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            '৳120',
            style: AppTextStyles.badge.copyWith(
              fontSize: 14,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadio(bool selected) => Container(
    width: 18,
    height: 18,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: selected ? AppColors.primary : AppColors.border,
        width: selected ? 5 : 1.5,
      ),
    ),
  );
}
