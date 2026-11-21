import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:famous_gadget/view/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class OrderStatusCard extends StatelessWidget {
  final String status;
  final bool isCurrent;

  const OrderStatusCard({
    super.key,
    required this.status,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Status',
                style: AppTextStyles.caption.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 2),
              Text(
                isCurrent ? 'Order Confirmed' : status,
                style: AppTextStyles.badge.copyWith(fontSize: 16),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.amber.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: AppTextStyles.badge.copyWith(
                fontSize: 11,
                color: AppColors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
