import 'package:flutter/material.dart';
import '../../../utils/app_text_styles.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({
    super.key,
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
  });

  final String image;
  final String name;
  final String detail;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(image, width: 40, height: 40, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.badge.copyWith(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(detail, style: AppTextStyles.caption.copyWith(fontSize: 11)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          price,
          style: AppTextStyles.badge.copyWith(
            fontSize: 13,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
