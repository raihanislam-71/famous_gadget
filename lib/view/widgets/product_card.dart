import 'package:famous_gadget/controllers/cart_controller.dart';
import 'package:famous_gadget/view/product_details/out_of_stock_product_details_screen.dart';
import 'package:famous_gadget/view/product_details/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product.dart';
import '../navigation/app_navigation.dart';
import '../utils/app_colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    this.productId,
    this.product,
    this.isInStock = true,
    this.width,
  }) : assert(
         productId != null || product != null,
         'Either productId or product must be provided',
       );

  final String? productId;
  final Product? product;
  final bool isInStock;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final targetProduct =
        product ?? Product.demoForId(productId ?? '0', isInStock: isInStock);
    final isAvailable = product != null ? product!.isInStock : isInStock;

    Widget cardWidget = Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        onTap: () {
          if (isAvailable) {
            AppRoutes.to<void>(
              route: AppRoutes.productDetails,
              arguments: {'productId': targetProduct.id},
              mobileBuilder: () =>
                  ProductDetailsScreen(productId: targetProduct.id),
            );
          } else {
            AppRoutes.to<void>(
              route: AppRoutes.outOfStockProduct,
              arguments: {'productId': targetProduct.id},
              mobileBuilder: () =>
                  OutOfStockProductDetailsScreen(productId: targetProduct.id),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _productImage(theme.colorScheme.surface, targetProduct),
            ),
            _productDetails(context, targetProduct, isAvailable),
          ],
        ),
      ),
    );

    if (width != null) {
      return SizedBox(width: width, child: cardWidget);
    }
    return cardWidget;
  }

  Widget _productImage(Color backgroundColor, Product product) {
    final discount = _discountPercent(product);
    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              child: Image.asset(
                product.imagePath,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: AppColors.pageBackground,
                  child: const Center(
                    child: Icon(
                      Icons.devices_other,
                      size: 44,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (discount > 0)
            Positioned(
              top: 8,
              left: 8,
              child: _DiscountTag(discount: discount),
            ),
        ],
      ),
    );
  }

  Widget _productDetails(
    BuildContext context,
    Product product,
    bool isAvailable,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleSmall?.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, color: AppColors.amber, size: 16),
              const SizedBox(width: 4),
              Text(
                product.rating,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(${product.reviewCount})',
                style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 8),
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
                        fontSize: 16,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (product.originalPrice > product.price)
                      Text(
                        '৳${_formatPrice(product.originalPrice)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                tooltip: isAvailable ? 'Add to cart' : 'Out of stock',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: isAvailable
                    ? () {
                        if (Get.isRegistered<CartController>()) {
                          Get.find<CartController>().addProduct(
                            product,
                            quantity: 1,
                            imagePath: product.imagePath,
                          );
                        } else {
                          Get.put(CartController()).addProduct(
                            product,
                            quantity: 1,
                            imagePath: product.imagePath,
                          );
                        }
                      }
                    : null,
                icon: Icon(
                  Icons.add_circle,
                  color: isAvailable ? AppColors.primary : Colors.grey,
                  size: 32,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  int _discountPercent(Product product) {
    if (product.originalPrice <= 0 || product.originalPrice <= product.price) {
      return 0;
    }
    return (100 - (product.price / product.originalPrice * 100)).round();
  }

  String _formatPrice(double price) {
    final digits = price.round().toString();
    return digits.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ',',
    );
  }
}

class _DiscountTag extends StatelessWidget {
  const _DiscountTag({required this.discount});

  final int discount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        '-$discount%',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
