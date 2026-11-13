part of '../product_details_screen.dart';

extension _ProductDetailsMobileImage on _ProductDetailsScreenState {
    Widget _buildMobileImageCard(BuildContext context, int discount) {
      final theme = Theme.of(context);
      return Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.dividerColor),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Hero(
                      tag: 'product_image_${_product.id}',
                      child: Image.asset(
                        _selectedImage,
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) => Icon(
                          Icons.devices_other,
                          size: 72,
                          color: AppColors.primary.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Wrap(
                      spacing: 6,
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
                ],
              ),
            );
    }
}
