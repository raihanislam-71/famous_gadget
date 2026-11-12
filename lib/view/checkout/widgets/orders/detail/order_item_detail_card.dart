import 'package:famous_gadget/view/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class OrderItemDetailCard extends StatelessWidget {
  final String name;
  final String detail;
  final String price;
  final String imagePath;
  final bool isPreview;

  const OrderItemDetailCard({
    super.key,
    required this.name,
    required this.detail,
    required this.price,
    required this.imagePath,
    this.isPreview = false,
  });

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
            'ITEMS ORDERED',
            style: AppTextStyles.badge.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
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
                      name,
                      style: AppTextStyles.badge.copyWith(fontSize: 13),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      detail,
                      style: AppTextStyles.caption.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),
              Text(
                price,
                style: AppTextStyles.badge.copyWith(
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
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
