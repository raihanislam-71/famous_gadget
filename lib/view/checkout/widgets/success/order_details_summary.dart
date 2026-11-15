import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';

class OrderDetailsSummary extends StatelessWidget {
  final bool isPreview;

  const OrderDetailsSummary({super.key, required this.isPreview});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            'Order Number',
            isPreview ? '#FG-DEMO' : '#FG-20240315',
            valueStyle: AppTextStyles.badge.copyWith(
              fontSize: 14,
              color: AppColors.surface,
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            'Total Amount',
            '৳26,118',
            valueStyle: AppTextStyles.badge.copyWith(
              fontSize: 14,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            'Payment Method',
            'Cash on Delivery',
            valueStyle: AppTextStyles.body.copyWith(
              fontSize: 13,
              height: 1,
              color: AppColors.surface,
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            'Order Status',
            isPreview ? 'Preview' : 'Processing',
            valueStyle: AppTextStyles.badge.copyWith(
              fontSize: 11,
              color: AppColors.amber,
            ),
            status: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    required TextStyle valueStyle,
    bool status = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.body.copyWith(
            fontSize: 13,
            height: 1,
            color: const Color(0xFF94A3B8),
          ),
        ),
        if (status)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.amber.withValues(alpha: 0.1),
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
