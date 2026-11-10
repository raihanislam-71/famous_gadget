import 'package:bdcalling_class/view/product_details/out_of_stock_product_details_screen.dart';
import 'package:bdcalling_class/view/product_details/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../navigation/app_navigation.dart';
import '../utils/app_colors.dart';
import '../utils/assets_path.dart';

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
    final tileColor = theme.colorScheme.surfaceContainerHighest;

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
              final image = _productImage(tileColor);
              final details = _productDetails(context);
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

  Widget _productImage(Color backgroundColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      color: backgroundColor,
      child: Hero(
        tag: 'product_image_$productId',
        child: Image.asset(
          AssetsPath.productImage,
          fit: BoxFit.contain,
          errorBuilder: (_, _, _) => const Icon(
            Icons.devices_other,
            size: 44,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _productDetails(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product name',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, color: AppColors.amber, size: 16),
              const SizedBox(width: 4),
              Text('4.5', style: theme.textTheme.labelMedium),
              const SizedBox(width: 4),
              Text('(100)', style: theme.textTheme.bodySmall),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6,
                  children: [
                    Text(
                      '৳999',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '৳1,290',
                      style: theme.textTheme.bodySmall?.copyWith(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.add_circle, color: AppColors.primary, size: 28),
            ],
          ),
        ],
      ),
    );
  }
}
