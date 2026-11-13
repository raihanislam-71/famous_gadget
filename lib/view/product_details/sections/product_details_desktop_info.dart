part of '../product_details_screen.dart';

extension _ProductDetailsDesktopInfo on _ProductDetailsScreenState {
    Widget _buildDesktopProductInfo(BuildContext context) {
      final theme = Theme.of(context);
      final discount = this._calculateDiscount();
      final savings = _product.originalPrice - _product.price;
  
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tag / Brand
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'AUTHENTIC GADGET • OFFICIAL BD WARRANTY',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Title
          Text(
            _product.name,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 12),
          // Social proof & Rating
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 6,
            children: [
              const RatingAndReviewsSection(),
              Text(
                '•',
                style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.isInStock ? Icons.check_circle : Icons.cancel,
                    size: 16,
                    color: widget.isInStock
                        ? AppColors.successGreen
                        : AppColors.dangerRed,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    widget.isInStock
                        ? 'In Stock (18 units ready)'
                        : 'Currently Unavailable',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: widget.isInStock
                          ? AppColors.successGreen
                          : AppColors.dangerRed,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Divider(color: theme.dividerColor),
          const SizedBox(height: 16),
          this._buildDesktopPriceShowcase(context, discount, savings),
          const SizedBox(height: 20),
          // Color / Variant picker
          ColorPicker(
            colors: const [
              Colors.black,
              Colors.white,
              AppColors.primary,
              Colors.blue,
              Colors.grey,
            ],
            colorNames: const [
              'Matte Black',
              'Pure White',
              'Sunset Orange',
              'Ocean Blue',
              'Space Gray',
            ],
            onColorSelected: (c) => this._updateState(() => _selectedColor = c),
          ),
          const SizedBox(height: 24),
          // Action Area: In Stock vs Out of Stock
          if (widget.isInStock)
            this._buildDesktopInStockActions(context)
          else
            this._buildDesktopOutOfStockActions(context),
          const SizedBox(height: 24),
          // Delivery Estimates Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Inside Dhaka',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Delivery Charge: ৳60 (within 24-48 hrs)',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: 1, height: 36, color: theme.dividerColor),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Outside Dhaka',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Delivery Charge: ৳120 (within 3-5 days)',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
}
