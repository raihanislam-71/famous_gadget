part of '../product_details_screen.dart';

extension _ProductDetailsDesktopLayout on _ProductDetailsScreenState {
    Widget _buildDesktopLayout(BuildContext context, BoxConstraints constraints) {
      Theme.of(context);
  
      return SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1280),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  this._buildDesktopBreadcrumbs(context),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column: Gallery & Trust Perks
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            this._buildDesktopGallery(context),
                            const SizedBox(height: 16),
                            this._buildGalleryThumbnails(context),
                            const SizedBox(height: 24),
                            this._buildTrustBadgesCard(context),
                          ],
                        ),
                      ),
                      const SizedBox(width: 36),
                      // Right Column: Details, Price, Actions, Shipping
                      Expanded(flex: 6, child: this._buildDesktopProductInfo(context)),
                    ],
                  ),
                  const SizedBox(height: 48),
                  this._buildDesktopSpecificationsCard(context),
                  const SizedBox(height: 32),
                  this._buildDesktopDescriptionCard(context),
                  const SizedBox(height: 32),
                  this._buildCustomerReviewsSection(context),
                  const SizedBox(height: 40),
                  this._buildRelatedProductsSection(context),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildDesktopBreadcrumbs(BuildContext context) {
      final theme = Theme.of(context);
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            InkWell(
              onTap: AppRoutes.backToHome,
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Row(
                  children: [
                    Icon(
                      Icons.home_outlined,
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Home',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '/',
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () => AppRoutes.to<void>(
                route: AppRoutes.products,
                mobileBuilder: () => const SizedBox.shrink(),
              ),
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  'Products',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '/',
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      );
    }
}
