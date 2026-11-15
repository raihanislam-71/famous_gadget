import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'web_product_card.dart';

class WebHotDealsSection extends StatelessWidget {
  const WebHotDealsSection({super.key, required this.onViewProducts});

  final ValueChanged<String> onViewProducts;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1280),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : AppColors.softPeach,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark ? const Color(0xFF334155) : const Color(0xFFFFE0C7),
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 680;
                final details = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Text(
                        'LIMITED TIME FLASH SALE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Hot Weekly Gadget Deals',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: compact ? 26 : 36,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Hurry up! Grab your favorite gadgets before they sell out. '
                      'Stock runs out fast.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    const Wrap(
                      spacing: 8,
                      children: [
                        _CountdownUnit(number: '02', label: 'Days'),
                        _CountdownUnit(number: '14', label: 'Hrs'),
                        _CountdownUnit(number: '45', label: 'Mins'),
                        _CountdownUnit(number: '12', label: 'Secs'),
                      ],
                    ),
                  ],
                );
                const offer = WebProductCard(
                  product: WebProduct(
                    'Arlo Pro 5 Smart 4K Camera',
                    18500,
                    24000,
                    '4.8',
                    '52',
                    'hot_camera.jpg',
                    'arlo-pro-5',
                  ),
                );
                if (compact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      details,
                      const SizedBox(height: 20),
                      const SizedBox(height: 280, child: offer),
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(flex: 2, child: details),
                    const SizedBox(width: 24),
                    const SizedBox(width: 280, height: 280, child: offer),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _CountdownUnit extends StatelessWidget {
  const _CountdownUnit({required this.number, required this.label});

  final String number;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1220),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
