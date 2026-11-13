import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/product_cart_button_controller.dart';
import '../../controllers/review_controller.dart';
import '../../models/product.dart';
import '../checkout/checkout_delivery_screen.dart';
import '../navigation/app_navigation.dart';
import '../review/review_screen.dart';
import '../utils/app_colors.dart';
import 'widgets/color_picker.dart';
import 'widgets/rating_and_reviews_section.dart';

part 'sections/product_details_chrome.dart';
part 'sections/product_details_desktop_layout.dart';
part 'sections/product_details_desktop_gallery.dart';
part 'sections/product_details_trust_badges.dart';
part 'sections/product_details_desktop_info.dart';
part 'sections/product_details_desktop_price.dart';
part 'sections/product_details_desktop_in_stock_actions.dart';
part 'sections/product_details_desktop_out_of_stock_actions.dart';
part 'sections/product_details_desktop_content.dart';
part 'sections/product_details_desktop_reviews.dart';
part 'sections/product_details_related_products.dart';
part 'sections/product_details_mobile_layout.dart';
part 'sections/product_details_mobile_image.dart';
part 'sections/product_details_mobile_content.dart';
part 'sections/product_details_mobile_bottom_bar.dart';

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
    final validId = widget.productId.trim().isEmpty
        ? 'anker-r50i'
        : widget.productId;
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

  void _updateState(VoidCallback callback) => setState(callback);

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
        content: Text(
          'Product link copied: famousgadget.bd/products/${_product.id}',
        ),
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
          appBar: isDesktop ? null : this._buildMobileAppBar(context),
          body: isDesktop
              ? this._buildDesktopLayout(context, constraints)
              : this._buildMobileLayout(context),
          bottomNavigationBar: isDesktop
              ? null
              : this._buildMobileBottomBar(context),
        );
      },
    );
  }
}
