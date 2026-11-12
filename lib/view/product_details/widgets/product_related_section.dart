import 'package:flutter/material.dart';
import '../../../models/product.dart';
import '../../utils/app_colors.dart';
import 'product_related_card.dart';

class ProductRelatedSection extends StatelessWidget {
  const ProductRelatedSection({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final related = Product.getRelatedProducts(product.id, count: 4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.recommend, color: AppColors.primary, size: 22),
            const SizedBox(width: 10),
            Text(
              product.isInStock
                  ? 'You May Also Like'
                  : 'Similar In-Stock Alternatives',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = (constraints.maxWidth - (3 * 16)) / 4;
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: related.map((p) {
                return SizedBox(
                  width: cardWidth.clamp(200, 320),
                  child: ProductRelatedCard(product: p),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
