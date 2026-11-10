import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/product_cart_button_controller.dart';
import '../../controllers/review_controller.dart';
import '../../models/product.dart';
import '../checkout/checkout_delivery_screen.dart';
import '../navigation/app_navigation.dart';
import '../navigation/app_routes.dart';
import '../review/review_screen.dart';
import '../utils/app_colors.dart';
import 'widgets/color_picker.dart';
import 'widgets/rating_and_reviews_section.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    this.productId = 'anker-r50i',
    this.isInStock = true,
  });

  final String productId;
  final bool isInStock;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late Product _product;
  late String _selectedImage;
  bool _isWishlisted = false;
  Color _selectedColor = Colors.black;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  @override
  void didUpdateWidget(covariant ProductDetailsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.productId != widget.productId ||
        oldWidget.isInStock != widget.isInStock) {
      _loadProduct();
    }
  }

  void _loadProduct() {
    final validId = widget.productId.trim().isEmpty ? 'anker-r50i' : widget.productId;
    _product = Product.demoForId(validId, isInStock: widget.isInStock);
    _selectedImage = _product.imagePath;
  }

  ProductCartButtonController get _cartBtnController {
    if (Get.isRegistered<ProductCartButtonController>()) {
      return Get.find<ProductCartButtonController>();
    }
    return Get.put(ProductCartButtonController());
  }

  ReviewController get _reviewController {
    if (Get.isRegistered<ReviewController>()) {
      return Get.find<ReviewController>();
    }
    return Get.put(ReviewController());
  }

  String _formatPrice(double price) => NumberFormat('#,##0').format(price);

  void _toggleWishlist() {
    setState(() {
      _isWishlisted = !_isWishlisted;
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isWishlisted
              ? '${_product.name} added to your wishlist!'
              : 'Removed from your wishlist',
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: _isWishlisted ? AppColors.primary : AppColors.navyDark,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _shareProduct() {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Product link copied: famousgadget.bd/products/${_product.id}'),
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _notifyRestock() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.notifications_active, color: AppColors.primary),
            SizedBox(width: 8),
            Text('Stock Alert'),
          ],
        ),
        content: Text(
          'We will notify you immediately once ${_product.name} is restocked!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _buyNow() {
    _cartBtnController.addToCart(_product);
    AppRoutes.to<void>(
      route: AppRoutes.checkoutDelivery,
      mobileBuilder: () => const CheckoutDeliveryScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 900;

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: isDesktop ? null : _buildMobileAppBar(context),
          body: isDesktop
              ? _buildDesktopLayout(context, constraints)
              : _buildMobileLayout(context),
          bottomNavigationBar: isDesktop ? null : _buildMobileBottomBar(context),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // MOBILE APP BAR
  // ---------------------------------------------------------------------------
  PreferredSizeWidget _buildMobileAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: const Text('Product Details'),
      backgroundColor: theme.colorScheme.surface,
      foregroundColor: theme.colorScheme.onSurface,
      surfaceTintColor: theme.colorScheme.surface,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        tooltip: 'Back',
        onPressed: () {
          if (kIsWeb) {
            AppRoutes.backToHome();
          } else {
            Get.back<void>();
          }
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            _isWishlisted ? Icons.favorite : Icons.favorite_border,
            color: _isWishlisted ? AppColors.dangerRed : theme.colorScheme.onSurface,
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
  Widget _buildDesktopLayout(BuildContext context, BoxConstraints constraints) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDesktopBreadcrumbs(context),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column: Gallery & Trust Perks
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          _buildDesktopGallery(context),
                          const SizedBox(height: 16),
                          _buildGalleryThumbnails(context),
                          const SizedBox(height: 24),
                          _buildTrustBadgesCard(context),
                        ],
                      ),
                    ),
                    const SizedBox(width: 36),
                    // Right Column: Details, Price, Actions, Shipping
                    Expanded(
                      flex: 6,
                      child: _buildDesktopProductInfo(context),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                _buildDesktopSpecificationsCard(context),
                const SizedBox(height: 32),
                _buildDesktopDescriptionCard(context),
                const SizedBox(height: 32),
                _buildCustomerReviewsSection(context),
                const SizedBox(height: 40),
                _buildRelatedProductsSection(context),
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
                  const Icon(Icons.arrow_back, size: 16),
                  const SizedBox(width: 6),
                  Text('Back to Home', style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text('/', style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(width: 12),
          Text(
            'Products',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 12),
          Text('/', style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(width: 12),
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

  Widget _buildDesktopGallery(BuildContext context) {
    final theme = Theme.of(context);
    final discount = _calculateDiscount();

    return Container(
      height: 460,
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: theme.brightness == Brightness.dark ? 0.25 : 0.04),
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
                  _buildStatusPill('SAVE $discount%', AppColors.primary, isSolid: true),
                _buildStatusPill(
                  widget.isInStock ? 'IN STOCK' : 'OUT OF STOCK',
                  widget.isInStock ? AppColors.successGreen : AppColors.dangerRed,
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
                _buildCircleActionButton(
                  icon: _isWishlisted ? Icons.favorite : Icons.favorite_border,
                  iconColor: _isWishlisted ? AppColors.dangerRed : theme.colorScheme.onSurface,
                  tooltip: 'Wishlist',
                  onTap: _toggleWishlist,
                ),
                const SizedBox(width: 8),
                _buildCircleActionButton(
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
            onTap: () => setState(() => _selectedImage = thumb),
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

  Widget _buildTrustBadgesCard(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131E30) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          _buildTrustRow(
            icon: Icons.local_shipping_outlined,
            title: 'Express Delivery in Bangladesh',
            subtitle: 'Inside Dhaka in 24-48 hours, outside Dhaka in 3-5 days',
          ),
          Divider(height: 20, color: theme.dividerColor.withValues(alpha: 0.5)),
          _buildTrustRow(
            icon: Icons.verified_user_outlined,
            title: '100% Authentic Product',
            subtitle: '1 Year Official Warranty with brand authenticity guarantee',
          ),
          Divider(height: 20, color: theme.dividerColor.withValues(alpha: 0.5)),
          _buildTrustRow(
            icon: Icons.replay_circle_filled_outlined,
            title: '7 Days Replacement Policy',
            subtitle: 'Hassle-free replacement for any genuine manufacturer defect',
          ),
          Divider(height: 20, color: theme.dividerColor.withValues(alpha: 0.5)),
          _buildTrustRow(
            icon: Icons.payments_outlined,
            title: 'Cash on Delivery Available',
            subtitle: 'Pay with cash upon delivery across all 64 districts',
          ),
        ],
      ),
    );
  }

  Widget _buildTrustRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopProductInfo(BuildContext context) {
    final theme = Theme.of(context);
    final discount = _calculateDiscount();
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
          child: Text(
            'AUTHENTIC GADGET • OFFICIAL BD WARRANTY',
            style: const TextStyle(
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
        Row(
          children: [
            const RatingAndReviewsSection(),
            const SizedBox(width: 16),
            Text(
              '•',
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(width: 16),
            Row(
              children: [
                Icon(
                  widget.isInStock ? Icons.check_circle : Icons.cancel,
                  size: 16,
                  color: widget.isInStock ? AppColors.successGreen : AppColors.dangerRed,
                ),
                const SizedBox(width: 6),
                Text(
                  widget.isInStock ? 'In Stock (18 units ready)' : 'Currently Unavailable',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: widget.isInStock ? AppColors.successGreen : AppColors.dangerRed,
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
        // Price Showcase
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                runSpacing: 8,
                children: [
                  Text(
                    '৳${_formatPrice(_product.price)}',
                    style: theme.textTheme.displaySmall?.copyWith(
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.successGreen.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Save ৳${_formatPrice(savings)} ($discount% OFF)',
                        style: const TextStyle(
                          color: AppColors.successGreen,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.bolt, size: 16, color: AppColors.amber),
                  const SizedBox(width: 4),
                  Text(
                    'Best price guaranteed with 100% Cash on Delivery across Bangladesh.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
          onColorSelected: (c) => setState(() => _selectedColor = c),
        ),
        const SizedBox(height: 24),
        // Action Area: In Stock vs Out of Stock
        if (widget.isInStock)
          _buildDesktopInStockActions(context)
        else
          _buildDesktopOutOfStockActions(context),
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
                  label: Text(
                    'Add to Cart · ৳${_formatPrice(_product.price * controller.quantity)}',
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
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
                  label: const Text(
                    'Buy Now',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary, width: 1.8),
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

  Widget _buildDesktopOutOfStockActions(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Out of stock warning banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.dangerRed.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.dangerRed.withValues(alpha: 0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline, color: AppColors.dangerRed, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Item Unavailable',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.dangerRed,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'This gadget is temporarily unavailable. We are restocking soon! Click below to receive an instant stock alert or explore similar in-stock items.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Disabled button & Notify me button
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: null,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  disabledBackgroundColor: theme.colorScheme.surfaceContainerHighest,
                  disabledForegroundColor: theme.colorScheme.onSurfaceVariant,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Currently Out of Stock'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: _notifyRestock,
                icon: const Icon(Icons.notifications_active_outlined, size: 20),
                label: const Text(
                  'Notify When Available',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.amber,
                  foregroundColor: Colors.black87,
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
    );
  }

  // ---------------------------------------------------------------------------
  // DESKTOP FULL-WIDTH BOTTOM SECTIONS
  // ---------------------------------------------------------------------------
  Widget _buildDesktopSpecificationsCard(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
            child: Row(
              children: [
                const Icon(Icons.tune, color: AppColors.primary, size: 22),
                const SizedBox(width: 10),
                Text(
                  'Key Specifications',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.dividerColor),
          ..._product.specifications.entries.toList().asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isEven = index % 2 == 0;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              color: isEven
                  ? (theme.brightness == Brightness.dark
                      ? const Color(0xFF142032)
                      : const Color(0xFFF8FAFC))
                  : Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      item.key,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      item.value,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDesktopDescriptionCard(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.description_outlined, color: AppColors.primary, size: 22),
              const SizedBox(width: 10),
              Text(
                'Description',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _product.description,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Enjoy peace of mind with authentic gadgets sourced directly from official distribution channels. Every purchase includes warranty coverage, professional after-sales support, and verified hardware testing.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerReviewsSection(BuildContext context) {
    final theme = Theme.of(context);
    final reviews = _reviewController.previewReviews;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.rate_review_outlined, color: AppColors.primary, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Customer Reviews',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const RatingAndReviewsSection(),
            ],
          ),
          const SizedBox(height: 20),
          // Reviews list
          ...reviews.map((rev) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark
                    ? const Color(0xFF142032)
                    : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.dividerColor.withValues(alpha: 0.6)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                        child: Text(
                          rev.name.isNotEmpty ? rev.name[0] : 'U',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  rev.name,
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.successGreen.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'Verified Buyer',
                                    style: TextStyle(
                                      color: AppColors.successGreen,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              DateFormat('dd MMM yyyy').format(rev.date),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RatingBarIndicator(
                        rating: rev.rating.toDouble(),
                        itemCount: 5,
                        itemSize: 14,
                        unratedColor: theme.colorScheme.surfaceContainerHighest,
                        itemBuilder: (_, _) => const Icon(Icons.star, color: AppColors.amber),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    rev.reviewText,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            );
          }),
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
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'See All Reviews',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedProductsSection(BuildContext context) {
    final theme = Theme.of(context);
    final related = Product.getRelatedProducts(_product.id, count: 4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.recommend, color: AppColors.primary, size: 22),
            const SizedBox(width: 10),
            Text(
              widget.isInStock ? 'You May Also Like' : 'Similar In-Stock Alternatives',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = (constraints.maxWidth - (3 * 16)) / 4;
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: related.map((p) {
                return SizedBox(
                  width: cardWidth.clamp(200, 320),
                  child: _buildRelatedProductCard(context, p),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRelatedProductCard(BuildContext context, Product p) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        AppRoutes.to<void>(
          route: p.isInStock ? AppRoutes.productDetails : AppRoutes.outOfStockProduct,
          arguments: {'productId': p.id},
          mobileBuilder: () => ProductDetailsScreen(
            productId: p.id,
            isInStock: p.isInStock,
          ),
        );
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                p.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => Icon(
                  Icons.devices_other,
                  size: 40,
                  color: AppColors.primary.withValues(alpha: 0.7),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              p.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '৳${_formatPrice(p.price)}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: p.isInStock
                        ? AppColors.successGreen.withValues(alpha: 0.15)
                        : AppColors.dangerRed.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    p.isInStock ? 'IN STOCK' : 'OOS',
                    style: TextStyle(
                      color: p.isInStock ? AppColors.successGreen : AppColors.dangerRed,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // MOBILE LAYOUT (< 900px)
  // ---------------------------------------------------------------------------
  Widget _buildMobileLayout(BuildContext context) {
    final theme = Theme.of(context);
    final discount = _calculateDiscount();
    final savings = _product.originalPrice - _product.price;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Card
          Container(
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
                        _buildStatusPill('SAVE $discount%', AppColors.primary, isSolid: true),
                      _buildStatusPill(
                        widget.isInStock ? 'IN STOCK' : 'OUT OF STOCK',
                        widget.isInStock ? AppColors.successGreen : AppColors.dangerRed,
                        isSolid: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildGalleryThumbnails(context),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
                border: Border.all(color: AppColors.dangerRed.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: AppColors.dangerRed, size: 20),
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
            onColorSelected: (c) => setState(() => _selectedColor = c),
          ),
          const SizedBox(height: 20),
          _buildMobileSpecifications(context),
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
          ..._reviewController.previewReviews.map((rev) => _buildMobileReviewCard(context, rev)),
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

  Widget _buildMobileSpecifications(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Key Specifications',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          for (final spec in _product.specifications.entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      spec.key,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      spec.value,
                      textAlign: TextAlign.end,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMobileReviewCard(BuildContext context, dynamic rev) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  rev.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              RatingBarIndicator(
                rating: rev.rating.toDouble(),
                itemCount: 5,
                itemSize: 12,
                unratedColor: theme.colorScheme.surfaceContainerHighest,
                itemBuilder: (_, _) => const Icon(Icons.star, color: AppColors.amber),
              ),
              const SizedBox(width: 8),
              Text(
                DateFormat('dd MMM yyyy').format(rev.date),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            rev.reviewText,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // MOBILE BOTTOM BAR
  // ---------------------------------------------------------------------------
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
                      disabledBackgroundColor: theme.colorScheme.surfaceContainerHighest,
                      disabledForegroundColor: theme.colorScheme.onSurfaceVariant,
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
  int _calculateDiscount() {
    if (_product.originalPrice <= 0) return 0;
    return ((_product.originalPrice - _product.price) /
            _product.originalPrice *
            100)
        .round();
  }

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
}
