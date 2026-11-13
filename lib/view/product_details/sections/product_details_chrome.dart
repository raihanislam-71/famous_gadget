part of '../product_details_screen.dart';

extension _ProductDetailsChrome on _ProductDetailsScreenState {
    PreferredSizeWidget _buildMobileAppBar(BuildContext context) {
      final theme = Theme.of(context);
      return AppBar(
        title: const Text('Product Details'),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        surfaceTintColor: theme.colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: kIsWeb
            ? null
            : IconButton(
                icon: const Icon(CupertinoIcons.back),
                tooltip: 'Back',
                onPressed: () => Get.back<void>(),
              ),
        actions: [
          IconButton(
            icon: Icon(
              _isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: _isWishlisted
                  ? AppColors.dangerRed
                  : theme.colorScheme.onSurface,
            ),
            tooltip: 'Wishlist',
            onPressed: _toggleWishlist,
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            tooltip: 'Share',
            onPressed: _shareProduct,
          ),
        ],
      );
    }
  
    // ---------------------------------------------------------------------------
    // DESKTOP / WEB LAYOUT (>= 900px)
    // ---------------------------------------------------------------------------

    Widget _buildStatusPill(String text, Color color, {bool isSolid = false}) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSolid ? color : color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSolid ? Colors.white : color,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
        ),
      );
    }

    Widget _buildCircleActionButton({
      required IconData icon,
      required Color iconColor,
      required String tooltip,
      required VoidCallback onTap,
    }) {
      final theme = Theme.of(context);
      return Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              shape: BoxShape.circle,
              border: Border.all(color: theme.dividerColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
        ),
      );
    }

    int _calculateDiscount() {
      if (_product.originalPrice <= 0) return 0;
      return ((_product.originalPrice - _product.price) /
              _product.originalPrice *
              100)
          .round();
    }
}
