part of '../product_details_screen.dart';

extension _ProductDetailsMobileLayout on _ProductDetailsScreenState {
  Widget _buildMobileLayout(BuildContext context) {
    final theme = Theme.of(context);
    final discount = this._calculateDiscount();
    final savings = _product.originalPrice - _product.price;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          this._buildMobileImageCard(context, discount),
          const SizedBox(height: 12),
          this._buildGalleryThumbnails(context),
          const SizedBox(height: 16),
          // Product Name
          Text(
            _product.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          const RatingAndReviewsSection(),
          const SizedBox(height: 12),
          // Price
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 4,
            children: [
              Text(
                '৳${_formatPrice(_product.price)}',
                style: theme.textTheme.headlineMedium?.copyWith(
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
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.successGreen.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Save ৳${_formatPrice(savings)}',
                    style: const TextStyle(
                      color: AppColors.successGreen,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Out of stock banner (mobile)
          if (!widget.isInStock) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.dangerRed.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.dangerRed.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: AppColors.dangerRed,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Currently Out of Stock. Notify me when it returns!',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.dangerRed,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _notifyRestock,
                    child: const Text('Notify Me'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          // Color selector
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
          const SizedBox(height: 20),
          this._buildMobileSpecifications(context),
          const SizedBox(height: 16),
          // Description
          Text('Description', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            _product.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          // Customer Reviews Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Customer Reviews', style: theme.textTheme.titleLarge),
              const RatingAndReviewsSection(),
            ],
          ),
          const SizedBox(height: 12),
          ..._reviewController.previewReviews.map(
            (rev) => this._buildMobileReviewCard(context, rev),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => AppRoutes.to<void>(
                route: AppRoutes.reviews,
                arguments: {'productId': _product.id},
                mobileBuilder: () => ReviewScreen(productId: _product.id),
              ),
              child: const Text('See All Reviews'),
            ),
          ),
        ],
      ),
    );
  }
}
