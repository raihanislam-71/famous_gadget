import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/product.dart';
import '../../navigation/app_navigation.dart';
import '../../utils/app_colors.dart';
import '../product_details_screen.dart';

class ProductRelatedCard extends StatelessWidget {
  const ProductRelatedCard({
    super.key,
    required this.product,
  });

  final Product product;

  String _formatPrice(double price) => NumberFormat('#,##0').format(price);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        AppRoutes.to<void>(
          route: product.isInStock
              ? AppRoutes.productDetails
              : AppRoutes.outOfStockProduct,
          arguments: {'productId': product.id},
          mobileBuilder: () =>
              ProductDetailsScreen(productId: product.id, isInStock: product.isInStock),
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
                product.imagePath,
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
              product.name,
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
                  '৳${_formatPrice(product.price)}',
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
                    color: product.isInStock
                        ? AppColors.successGreen.withValues(alpha: 0.15)
                        : AppColors.dangerRed.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    product.isInStock ? 'IN STOCK' : 'OOS',
                    style: TextStyle(
                      color: product.isInStock
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
}
