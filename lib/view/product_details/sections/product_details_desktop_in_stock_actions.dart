part of '../product_details_screen.dart';

extension _ProductDetailsDesktopInStockActions on _ProductDetailsScreenState {
    Widget _buildDesktopInStockActions(BuildContext context) {
      final theme = Theme.of(context);
  
      return GetBuilder<ProductCartButtonController>(
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Quantity stepper
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    border: Border.all(color: theme.dividerColor, width: 1.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, size: 18),
                        tooltip: 'Decrease',
                        onPressed: () => controller.updateQuantity(-1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '${controller.quantity}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, size: 18),
                        tooltip: 'Increase',
                        onPressed: () => controller.updateQuantity(1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Add to Cart button
                Expanded(
                  flex: 3,
                  child: FilledButton.icon(
                    onPressed: () => controller.addToCart(_product),
                    icon: const Icon(Icons.shopping_bag_outlined, size: 20),
                    label: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Add to Cart · ৳${_formatPrice(_product.price * controller.quantity)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 1,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Buy Now button
                Expanded(
                  flex: 2,
                  child: OutlinedButton.icon(
                    onPressed: _buyNow,
                    icon: const Icon(Icons.bolt, size: 20),
                    label: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Buy Now',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(
                        color: AppColors.primary,
                        width: 1.8,
                      ),
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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
