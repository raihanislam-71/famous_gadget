import 'package:bdcalling_class/view/product_details/out_of_stock_product_details_screen.dart';
import 'package:bdcalling_class/view/product_details/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/assets_path.dart';
import '../navigation/app_navigation.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.productId,
    this.isInStock = true,
  });

  final String productId;
  final bool isInStock;

  @override
  Widget build(BuildContext context) {
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
        elevation: 3,
        color: Colors.white,
        child: SizedBox(
          width: 140,
          child: Column(
            children: [
              Hero(
                tag: 'product_image_$productId',
                child: Container(
                  width: 150,
                  height: 100,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.themeColor.withValues(alpha: 0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    image: const DecorationImage(
                      image: AssetImage(AssetsPath.productImage),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Product name",
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star_outline, color: Colors.amber),
                        const Text(
                          "4.5",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "(100)",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "\$999",
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: AppColors.themeColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "\$1290",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        Card(
                          color: AppColors.themeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.add,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
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
}
