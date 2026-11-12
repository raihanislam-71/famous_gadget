import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:flutter/material.dart';

class WebTrustSection extends StatelessWidget {
  const WebTrustSection({super.key});

  @override
  Widget build(BuildContext context) {
    const trustItems = [
      (
        'Cash on Delivery BD',
        'Inspect your package first, then pay',
        Icons.local_shipping_outlined,
      ),
      (
        'Genuine Warranty',
        '100% authentic brand replacements',
        Icons.verified_outlined,
      ),
      ('7-Day Returns', 'Hassle-free product exchange policy', Icons.sync),
      (
        'Premium Support',
        'Professional 24/7 client helpline',
        Icons.support_agent,
      ),
    ];

    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 24,
      runSpacing: 18,
      children: trustItems
          .map(
            (item) => SizedBox(
              width: 255,
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(item.$3, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.$1,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.$2,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
