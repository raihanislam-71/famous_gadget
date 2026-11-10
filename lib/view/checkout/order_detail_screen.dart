import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/assets_path.dart';

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
    final isCurrent = status == 'Processing';
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDarkMode
            ? Brightness.light
            : Brightness.dark,
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
            _buildStatusCard(context, isCurrent),
            const SizedBox(height: 16),
            _buildTrackingCard(context),
            const SizedBox(height: 16),
            _buildDeliveryCard(context),
            const SizedBox(height: 16),
            _buildItemsCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context, bool isCurrent) {
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

  Widget _buildTrackingCard(BuildContext context) {
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
            'DELIVERY TRACKING',
            style: AppTextStyles.badge.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTrackingStep(
                context,
                'Ordered',
                'Mar 15, 2024',
                isComplete: true,
              ),
              _buildTrackingStep(
                context,
                'Confirmed',
                'Mar 15, 2024',
                isComplete: true,
              ),
              _buildTrackingStep(context, 'Shipped', 'Pending'),
              _buildTrackingStep(context, 'Delivered', 'Pending'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingStep(
    BuildContext context,
    String title,
    String date, {
    bool isComplete = false,
  }) {
    final color = isComplete
        ? AppColors.primary
        : Theme.of(context).dividerColor;
    return SizedBox(
      width: 68,
      child: Column(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: isComplete
                ? Center(
                    child: SvgPicture.asset(
                      AssetsPath.orderTrackingCheck,
                      width: 8,
                      height: 8,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 6),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: AppTextStyles.badge.copyWith(
              fontSize: 12,
              color: isComplete
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(
              fontSize: 9,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
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
              _buildDeliveryInfo(
                context,
                'Shipping Option',
                'Standard Delivery',
              ),
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
      crossAxisAlignment: alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.caption.copyWith(fontSize: 12)),
        const SizedBox(height: 2),
        Text(value, style: AppTextStyles.uiSemibold.copyWith(fontSize: 13)),
      ],
    );
  }

  Widget _buildItemsCard(BuildContext context) {
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
            'ITEMS ORDERED',
            style: AppTextStyles.badge.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  AssetsPath.orderDetailSonyImage,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sony WH-1000XM5',
                      style: AppTextStyles.badge.copyWith(fontSize: 13),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Qty: 1 • Navy Blue',
                      style: AppTextStyles.caption.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),
              Text(
                '৳32,500',
                style: AppTextStyles.badge.copyWith(
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          if (isPreview) ...[
            const SizedBox(height: 12),
            const Text(
              'Demo order detail. Live tracking requires the API.',
              style: AppTextStyles.caption,
            ),
          ],
        ],
      ),
    );
  }
}
