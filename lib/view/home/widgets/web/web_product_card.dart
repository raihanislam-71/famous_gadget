import 'package:famous_gadget/controllers/cart_controller.dart';
import 'package:famous_gadget/models/product.dart';
import 'package:famous_gadget/view/navigation/app_navigation.dart';
import 'package:famous_gadget/view/product_details/product_details_screen.dart';
import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class WebProduct {
  const WebProduct(
    this.name,
    this.price,
    this.originalPrice,
    this.rating,
    this.reviewCount,
    this.imageName,
    this.id,
  );

  final String name;
  final double price;
  final double originalPrice;
  final String rating;
  final String reviewCount;
  final String imageName;
  final String id;

  Product toProduct() => Product(
    id: id,
    name: name,
    price: price,
    originalPrice: originalPrice,
    description:
        'Authentic gadget with official warranty and cash on delivery.',
    specifications: const {},
  );
}

class WebProductCard extends StatelessWidget {
  const WebProductCard({super.key, required this.product});

  final WebProduct product;

  @override
  Widget build(BuildContext context) {
    final imagePath = 'assets/images/figma_web/${product.imageName}';
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        onTap: () => AppRoutes.to<void>(
          route: AppRoutes.productDetails,
          arguments: {'productId': product.id},
          mobileBuilder: () => ProductDetailsScreen(productId: product.id),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(
                            color: AppColors.pageBackground,
                            child: const Icon(
                              Icons.devices_other,
                              size: 44,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: _Tag(
                        text: '-${_discountPercent()}%',
                        background: AppColors.primary,
                        foreground: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          product.rating,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${product.reviewCount})',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '৳${_formatPrice(product.price)}',
                                maxLines: 1,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '৳${_formatPrice(product.originalPrice)}',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color,
                                  fontSize: 11,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton.filled(
                          tooltip: 'Add to cart',
                          onPressed: () =>
                              Get.find<CartController>().addProduct(
                                product.toProduct(),
                                quantity: 1,
                                imagePath: imagePath,
                              ),
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(36, 36),
                            padding: EdgeInsets.zero,
                          ),
                          icon: const Icon(Icons.add, size: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _discountPercent() =>
      (100 - product.price / product.originalPrice * 100).round();

  String _formatPrice(double value) => value.toStringAsFixed(0);
}

class _Tag extends StatelessWidget {
  const _Tag({
    required this.text,
    required this.background,
    required this.foreground,
  });

  final String text;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: foreground,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
