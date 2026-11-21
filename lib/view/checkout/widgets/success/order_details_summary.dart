import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';

class OrderDetailsSummary extends StatelessWidget {
  final bool isPreview;

  const OrderDetailsSummary({super.key, required this.isPreview});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final valueColor = theme.colorScheme.onSurface;
    final labelColor = theme.brightness == Brightness.dark
        ? const Color(0xFF94A3B8)
        : AppColors.secondaryText;
    final statusColor = theme.brightness == Brightness.dark
        ? AppColors.amber
        : AppColors.amberTextLight;
    return Container(
      key: const ValueKey('orderDetailsSummary'),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            'Order Number',
            isPreview ? '#FG-DEMO' : '#FG-20240315',
            labelColor: labelColor,
            valueStyle: AppTextStyles.badge.copyWith(
              fontSize: 14,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            'Total Amount',
            '৳26,118',
            labelColor: labelColor,
            valueStyle: AppTextStyles.badge.copyWith(
              fontSize: 14,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            'Payment Method',
            'Cash on Delivery',
            labelColor: labelColor,
            valueStyle: AppTextStyles.body.copyWith(
              fontSize: 13,
              height: 1,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            'Order Status',
            isPreview ? 'Preview' : 'Processing',
            labelColor: labelColor,
            valueStyle: AppTextStyles.badge.copyWith(
              fontSize: 11,
              color: statusColor,
            ),
            status: true,
            statusColor: statusColor,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    required TextStyle valueStyle,
    required Color labelColor,
    bool status = false,
    Color statusColor = AppColors.amber,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.body.copyWith(
            fontSize: 13,
            height: 1,
            color: labelColor,
          ),
        ),
        if (status)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(value, style: valueStyle),
          )
        else
          Text(value, style: valueStyle),
      ],
    );
  }
}
