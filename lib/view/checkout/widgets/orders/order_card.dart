import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import 'order_summary.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order, required this.onTap});

  final OrderSummary order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.number,
                    style: AppTextStyles.badge.copyWith(
                      fontSize: 15,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  _OrderStatusBadge(order: order),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Divider(
                  height: 1,
                  color: Theme.of(context).dividerColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Placed on ${order.date}',
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 12,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${order.itemCount} '
                        '${order.itemCount == 1 ? 'item' : 'items'}',
                        style: AppTextStyles.body.copyWith(
                          fontSize: 13,
                          height: 1,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Total Amount',
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 12,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        order.total,
                        style: AppTextStyles.badge.copyWith(
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderStatusBadge extends StatelessWidget {
  const _OrderStatusBadge({required this.order});

  final OrderSummary order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: order.statusBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        order.status,
        style: AppTextStyles.badge.copyWith(
          fontSize: 11,
          color: order.statusColor,
        ),
      ),
    );
  }
}
