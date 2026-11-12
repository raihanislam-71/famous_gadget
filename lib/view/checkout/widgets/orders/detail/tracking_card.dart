import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:famous_gadget/view/utils/app_text_styles.dart';
import 'package:famous_gadget/view/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrackingCard extends StatelessWidget {
  const TrackingCard({super.key});

  @override
  Widget build(BuildContext context) {
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
              _buildTrackingStep(context, 'Ordered', 'Mar 15, 2024', isComplete: true),
              _buildTrackingStep(context, 'Confirmed', 'Mar 15, 2024', isComplete: true),
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
    final color = isComplete ? AppColors.primary : Theme.of(context).dividerColor;
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
}
