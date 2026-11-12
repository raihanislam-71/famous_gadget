import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class ProductTrustBadgesCard extends StatelessWidget {
  const ProductTrustBadgesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131E30) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          _buildTrustRow(
            context,
            icon: Icons.local_shipping_outlined,
            title: 'Express Delivery in Bangladesh',
            subtitle: 'Inside Dhaka in 24-48 hours, outside Dhaka in 3-5 days',
          ),
          Divider(height: 20, color: theme.dividerColor.withValues(alpha: 0.5)),
          _buildTrustRow(
            context,
            icon: Icons.verified_user_outlined,
            title: '100% Authentic Product',
            subtitle:
                '1 Year Official Warranty with brand authenticity guarantee',
          ),
          Divider(height: 20, color: theme.dividerColor.withValues(alpha: 0.5)),
          _buildTrustRow(
            context,
            icon: Icons.replay_circle_filled_outlined,
            title: '7 Days Replacement Policy',
            subtitle:
                'Hassle-free replacement for any genuine manufacturer defect',
          ),
          Divider(height: 20, color: theme.dividerColor.withValues(alpha: 0.5)),
          _buildTrustRow(
            context,
            icon: Icons.payments_outlined,
            title: 'Cash on Delivery Available',
            subtitle: 'Pay with cash upon delivery across all 64 districts',
          ),
        ],
      ),
    );
  }

  Widget _buildTrustRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
