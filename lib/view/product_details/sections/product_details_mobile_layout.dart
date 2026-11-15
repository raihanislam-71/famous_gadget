part of '../product_details_screen.dart';

extension _ProductDetailsMobileLayout on _ProductDetailsScreenState {
  List<String> get _galleryImages => [
    _product.imagePath,
    'assets/images/figma_web/hero_watch.jpg',
    'assets/images/figma_web/new_earbuds.jpg',
    'assets/images/figma_web/recommended_headset.jpg',
  ];

  Widget _buildMobileImageCard(BuildContext context) => ProductImageSlider(
    productId: _product.id,
    imagePaths: _galleryImages,
    selectedImagePath: _selectedImage,
    mobileStyle: true,
    onImageChanged: (imagePath) =>
        _updateState(() => _selectedImage = imagePath),
  );

  Widget _buildMobileLayout(BuildContext context) {
    final theme = Theme.of(context);
    final discount = _calculateDiscount();
    final savings = _product.originalPrice - _product.price;

    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildMobileImageCard(context),
          Container(
            color: theme.colorScheme.surface,
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  children: [
                    if (discount > 0)
                      _mobileBadge('SAVE $discount%', AppColors.primary),
                    _mobileBadge(
                      widget.isInStock ? 'IN STOCK' : 'OUT OF STOCK',
                      widget.isInStock
                          ? AppColors.successGreen
                          : AppColors.dangerRed,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  _product.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const RatingAndReviewsSection(),
                const SizedBox(height: 10),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  runSpacing: 4,
                  children: [
                    Text(
                      '৳${_formatPrice(_product.price)}',
                      style: theme.textTheme.headlineSmall?.copyWith(
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
                      Text(
                        'Save ৳${_formatPrice(savings)}',
                        style: const TextStyle(
                          color: AppColors.successGreen,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ],
                ),
                if (!widget.isInStock) ...[
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _notifyRestock,
                    icon: const Icon(Icons.notifications_active_outlined),
                    label: const Text('Notify Me When Available'),
                  ),
                ],
                const SizedBox(height: 16),
                Text(
                  'Select Color',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _colorChip('Navy Blue', const Color(0xFF2455A4)),
                    _colorChip('Carbon Black', const Color(0xFF171923)),
                    _colorChip('Platinum Silver', const Color(0xFFC3C8D0)),
                  ],
                ),
                const SizedBox(height: 18),
                _buildMobileSpecifications(context),
              ],
            ),
          ),
          Container(
            color: AppColors.pageBackground,
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _product.description,
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.55),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Reviews',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const RatingAndReviewsSection(),
                  ],
                ),
                const SizedBox(height: 8),
                ..._reviewController.previewReviews.map(
                  (review) => _buildMobileReviewCard(context, review),
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
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      backgroundColor: theme.colorScheme.surface,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text('See All Reviews'),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mobileBadge(String label, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(7),
    ),
    child: Text(
      label,
      style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w800),
    ),
  );

  Widget _colorChip(String label, Color color) {
    final selected = selectedColor == color;
    return InkWell(
      onTap: () => this._updateState(() => selectedColor = color),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.08)
              : AppColors.pageBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.primary : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.primary : AppColors.navyDark,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
