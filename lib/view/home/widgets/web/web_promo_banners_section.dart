import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:flutter/material.dart';

class WebPromoBannersSection extends StatelessWidget {
  const WebPromoBannersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const banners = [
            _PromoCard(
              title: 'Free Shipping Nationwide',
              subtitle: 'On all authentic gadget orders above ৳5,000.',
              icon: Icons.local_shipping_outlined,
            ),
            _PromoCard(
              title: 'Safe Cash on Delivery',
              subtitle: 'Pay only after inspecting your premium gadgets.',
              icon: Icons.verified_user_outlined,
            ),
          ];
          return Flex(
            direction: constraints.maxWidth < 620
                ? Axis.vertical
                : Axis.horizontal,
            children: [
              for (var index = 0; index < banners.length; index++) ...[
                if (index > 0)
                  SizedBox(
                    width: constraints.maxWidth < 620 ? 12 : 16,
                    height: constraints.maxWidth < 620 ? 12 : 0,
                  ),
                Flexible(
                  flex: constraints.maxWidth < 620 ? 0 : 1,
                  fit: constraints.maxWidth < 620
                      ? FlexFit.loose
                      : FlexFit.tight,
                  child: banners[index],
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  const _PromoCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.45)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
