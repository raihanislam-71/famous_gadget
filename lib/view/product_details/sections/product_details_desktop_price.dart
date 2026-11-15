part of '../product_details_screen.dart';

extension _ProductDetailsDesktopPrice on _ProductDetailsScreenState {
    Widget _buildDesktopPriceShowcase(
      BuildContext context,
      int discount,
      double savings,
    ) {
      final theme = Theme.of(context);
      return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    Text(
                      '৳${_formatPrice(_product.price)}',
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (_product.originalPrice > _product.price)
                      Text(
                        '৳${_formatPrice(_product.originalPrice)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    if (discount > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.successGreen.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Save ৳${_formatPrice(savings)} ($discount% OFF)',
                          style: const TextStyle(
                            color: AppColors.successGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.bolt, size: 16, color: AppColors.amber),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Best price guaranteed with 100% Cash on Delivery across Bangladesh.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
    }
}
