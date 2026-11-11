import 'package:famous_gadget/view/product_details/out_of_stock_product_details_screen.dart';
import 'package:famous_gadget/view/product_details/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../navigation/app_navigation.dart';
import '../utils/app_colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.productId,
    this.isInStock = true,
    this.width = 184,
  });

  final String productId;
  final bool isInStock;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = Product.demoForId(productId, isInStock: isInStock);

    return GestureDetector(
      onTap: () {
        if (isInStock) {
          AppRoutes.to<void>(
            route: AppRoutes.productDetails,
            arguments: {'productId': productId},
            mobileBuilder: () => ProductDetailsScreen(productId: productId),
          );
        } else {
          AppRoutes.to<void>(
            route: AppRoutes.outOfStockProduct,
            arguments: {'productId': productId},
            mobileBuilder: () =>
                OutOfStockProductDetailsScreen(productId: productId),
          );
        }
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 1,
        color: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: SizedBox(
          width: width,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final hasBoundedHeight = constraints.maxHeight.isFinite;
              final image = _productImage(
                theme.colorScheme.surface,
                product.imagePath,
              );
              final details = _productDetails(context, product);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (hasBoundedHeight)
                    Expanded(flex: 5, child: image)
                  else
                    SizedBox(
                      height: width == double.infinity ? 150 : 100,
                      child: image,
                    ),
                  if (hasBoundedHeight)
                    Expanded(flex: 4, child: details)
                  else
                    details,
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _productImage(Color backgroundColor, String imagePath) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      color: backgroundColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Hero(
          tag: 'product_image_$productId',
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => const Center(
              child: Icon(
                Icons.devices_other,
                size: 44,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _productDetails(BuildContext context, Product product) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 175;
        return Padding(
          padding: EdgeInsets.fromLTRB(
            compact ? 8 : 10,
            4,
            compact ? 8 : 10,
            6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: compact ? 11 : 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: AppColors.amber,
                    size: compact ? 14 : 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '4.5',
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontSize: compact ? 10 : 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(100)',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: compact ? 9 : 10,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '৳${_formatPrice(product.price)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontSize: compact ? 13 : 14,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          '৳${_formatPrice(product.originalPrice)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: compact ? 9 : 10,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.add_circle,
                    color: AppColors.primary,
                    size: compact ? 26 : 28,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatPrice(double price) {
    final digits = price.round().toString();
    return digits.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ',',
    );
  }
}
