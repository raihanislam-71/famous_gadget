import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_text_styles.dart';
import 'widgets/orders/detail/order_item_detail_card.dart';
import 'widgets/orders/detail/order_status_card.dart';
import 'widgets/orders/detail/tracking_card.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({
    super.key,
    required this.orderNumber,
    required this.status,
    this.isPreview = false,
  });

  final String orderNumber;
  final String status;
  final bool isPreview;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isCurrent = status == 'Processing';

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          elevation: 0,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 16,
          title: Text(
            'Order $orderNumber',
            style: AppTextStyles.h2.copyWith(fontSize: 18),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            OrderStatusCard(status: status, isCurrent: isCurrent),
            const SizedBox(height: 16),
            const TrackingCard(),
            const SizedBox(height: 16),
            _buildDeliveryCard(context),
            const SizedBox(height: 16),
            OrderItemDetailCard(
              name: 'Sony WH-1000XM5',
              detail: 'Qty: 1 • Navy Blue',
              price: '৳32,500',
              imagePath: 'assets/images/order_detail_sony.png', // Corrected path
              isPreview: isPreview,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping Address',
            style: AppTextStyles.caption.copyWith(fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            'Arif Rahman',
            style: AppTextStyles.badge.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            'House 24, Road 5, Sector 3, Uttara, Dhaka',
            style: AppTextStyles.body.copyWith(
              fontSize: 13,
              height: 1.3,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            '+880 1712 345678',
            style: AppTextStyles.body.copyWith(
              fontSize: 13,
              height: 1.5,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: Theme.of(context).dividerColor),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDeliveryInfo(context, 'Shipping Option', 'Standard Delivery'),
              _buildDeliveryInfo(
                context,
                'Payment Method',
                'Cash on Delivery',
                alignEnd: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfo(
    BuildContext context,
    String label,
    String value, {
    bool alignEnd = false,
  }) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.caption.copyWith(fontSize: 12)),
        const SizedBox(height: 2),
        Text(value, style: AppTextStyles.uiSemibold.copyWith(fontSize: 13)),
      ],
    );
  }
}
