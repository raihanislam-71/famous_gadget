import 'package:famous_gadget/models/product.dart';
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'color_picker.dart';
import 'rating_and_reviews_section.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({
    super.key,
    required this.product,
    required this.isInStock,
    required this.onBuyNow,
    required this.onNotify,
  });

  final Product product;
  final bool isInStock;
  final VoidCallback onBuyNow;
  final VoidCallback onNotify;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.name, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        const RatingAndReviewsSection(),
        const SizedBox(height: 18),
        Text('৳${product.price}', style: theme.textTheme.displaySmall?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w800)),
        const SizedBox(height: 16),
        ColorPicker(
          colors: const [Colors.black, Colors.white, AppColors.primary, Colors.blue, Colors.grey],
          colorNames: const ['Matte Black', 'Pure White', 'Sunset Orange', 'Ocean Blue', 'Space Gray'],
          onColorSelected: (c) {},
        ),
        const SizedBox(height: 24),
        if (isInStock)
          FilledButton(onPressed: onBuyNow, child: const Text('Buy Now'))
        else
          FilledButton(onPressed: onNotify, child: const Text('Notify Me')),
      ],
    );
  }
}
