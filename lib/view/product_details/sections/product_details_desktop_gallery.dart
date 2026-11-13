part of '../product_details_screen.dart';

extension _ProductDetailsDesktopGallery on _ProductDetailsScreenState {
    Widget _buildDesktopGallery(BuildContext context) {
      final theme = Theme.of(context);
      final discount = this._calculateDiscount();
  
      return Container(
        height: 460,
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.dividerColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: theme.brightness == Brightness.dark ? 0.25 : 0.04,
              ),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Hero(
                tag: 'product_image_${_product.id}',
                child: Image.asset(
                  _selectedImage,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (_, _, _) => Center(
                    child: Icon(
                      Icons.devices_other,
                      size: 110,
                      color: AppColors.primary.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 18,
              left: 18,
              child: Wrap(
                spacing: 8,
                children: [
                  if (discount > 0)
                    this._buildStatusPill(
                      'SAVE $discount%',
                      AppColors.primary,
                      isSolid: true,
                    ),
                  this._buildStatusPill(
                    widget.isInStock ? 'IN STOCK' : 'OUT OF STOCK',
                    widget.isInStock
                        ? AppColors.successGreen
                        : AppColors.dangerRed,
                    isSolid: true,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 18,
              right: 18,
              child: Row(
                children: [
                  this._buildCircleActionButton(
                    icon: _isWishlisted ? Icons.favorite : Icons.favorite_border,
                    iconColor: _isWishlisted
                        ? AppColors.dangerRed
                        : theme.colorScheme.onSurface,
                    tooltip: 'Wishlist',
                    onTap: _toggleWishlist,
                  ),
                  const SizedBox(width: 8),
                  this._buildCircleActionButton(
                    icon: Icons.share_outlined,
                    iconColor: theme.colorScheme.onSurface,
                    tooltip: 'Share',
                    onTap: _shareProduct,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildGalleryThumbnails(BuildContext context) {
      final theme = Theme.of(context);
      final thumbnails = [
        _product.imagePath,
        'assets/images/figma_web/hero_watch.jpg',
        'assets/images/figma_web/new_earbuds.jpg',
        'assets/images/figma_web/recommended_headset.jpg',
      ];
  
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: thumbnails.map((thumb) {
          final isSelected = _selectedImage == thumb;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: InkWell(
              onTap: () => this._updateState(() => _selectedImage = thumb),
              borderRadius: BorderRadius.circular(12),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 72,
                height: 72,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : theme.dividerColor,
                    width: isSelected ? 2.5 : 1,
                  ),
                ),
                child: Image.asset(
                  thumb,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => Icon(
                    Icons.image,
                    size: 28,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      );
    }
}
