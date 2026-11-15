part of '../product_details_screen.dart';

extension _ProductDetailsRelatedProducts on _ProductDetailsScreenState {
    Widget _buildRelatedProductsSection(BuildContext context) {
      final theme = Theme.of(context);
      final related = Product.getRelatedProducts(_product.id, count: 4);
  
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.recommend, color: AppColors.primary, size: 22),
              const SizedBox(width: 10),
              Text(
                widget.isInStock
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
                    child: this._buildRelatedProductCard(context, p),
                  );
                }).toList(),
              );
            },
          ),
        ],
      );
    }

    Widget _buildRelatedProductCard(BuildContext context, Product p) {
      final theme = Theme.of(context);
  
      return InkWell(
        onTap: () {
          AppRoutes.to<void>(
            route: p.isInStock
                ? AppRoutes.productDetails
                : AppRoutes.outOfStockProduct,
            arguments: {'productId': p.id},
            mobileBuilder: () =>
                ProductDetailsScreen(productId: p.id, isInStock: p.isInStock),
          );
        },
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 130,
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  p.imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => Icon(
                    Icons.devices_other,
                    size: 40,
                    color: AppColors.primary.withValues(alpha: 0.7),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                p.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '৳${_formatPrice(p.price)}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: p.isInStock
                          ? AppColors.successGreen.withValues(alpha: 0.15)
                          : AppColors.dangerRed.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      p.isInStock ? 'IN STOCK' : 'OOS',
                      style: TextStyle(
                        color: p.isInStock
                            ? AppColors.successGreen
                            : AppColors.dangerRed,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  
    // ---------------------------------------------------------------------------
    // MOBILE LAYOUT (< 900px)
    // ---------------------------------------------------------------------------
}
