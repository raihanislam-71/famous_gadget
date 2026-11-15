part of '../product_details_screen.dart';

extension _ProductDetailsMobileBottomBar on _ProductDetailsScreenState {
    Widget _buildMobileBottomBar(BuildContext context) {
      final theme = Theme.of(context);
  
      return GetBuilder<ProductCartButtonController>(
        builder: (controller) => Container(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(top: BorderSide(color: theme.dividerColor)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: SafeArea(
            child: widget.isInStock
                ? Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => controller.updateQuantity(-1),
                              icon: const Icon(Icons.remove),
                            ),
                            Text(
                              '${controller.quantity}',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            IconButton(
                              onPressed: () => controller.updateQuantity(1),
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () => controller.addToCart(_product),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Text(
                            'Add to Cart · ৳${_formatPrice(_product.price * controller.quantity)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: null,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        disabledBackgroundColor:
                            theme.colorScheme.surfaceContainerHighest,
                        disabledForegroundColor:
                            theme.colorScheme.onSurfaceVariant,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text('Currently Out of Stock'),
                    ),
                  ),
          ),
        ),
      );
    }
  
    // ---------------------------------------------------------------------------
    // HELPER WIDGETS & METHODS
    // ---------------------------------------------------------------------------
}
