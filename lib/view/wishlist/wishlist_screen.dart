import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../models/wishlist_item_model.dart';
import '../navigation/app_navigation.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/assets_path.dart';
import 'widgets/wishlist_product_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<WishlistItem> _items = [
    const WishlistItem(
      name: 'Sony WH-1000XM5',
      price: '৳32,500',
      imagePath: AssetsPath.wishlistSonyImage,
    ),
    const WishlistItem(
      name: 'Anker Soundcore R50i',
      price: '৳1,999',
      imagePath: AssetsPath.wishlistAnkerImage,
    ),
    const WishlistItem(
      name: 'Haylou Solar Lite',
      price: '৳2,799',
      imagePath: AssetsPath.wishlistHaylouImage,
    ),
    const WishlistItem(
      name: 'A4Tech Bloody B820R',
      price: '৳4,200',
      imagePath: AssetsPath.wishlistA4TechImage,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _buildStatusBar(context),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: _buildAppBar(),
        body: _items.isEmpty ? _buildEmptyView() : _buildWishlistGrid(),
      ),
    );
  }

  SystemUiOverlayStyle _buildStatusBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).scaffoldBackgroundColor,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      title: Text(
        'My Wishlist (${_items.length})',
        style: AppTextStyles.h2.copyWith(fontSize: 18),
      ),
      leading: kIsWeb
          ? null
          : IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: () => Navigator.canPop(context)
                  ? Navigator.pop(context)
                  : AppRoutes.backToHome(),
            ),
    );
  }

  Widget _buildEmptyView() => Center(
    child: Text(
      'Your wishlist is empty',
      style: AppTextStyles.body.copyWith(color: AppColors.secondaryText),
    ),
  );

  Widget _buildWishlistGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxis = constraints.maxWidth >= 900
            ? 4
            : (constraints.maxWidth >= 600 ? 3 : 2);
        final cardWidth =
            (constraints.maxWidth.clamp(0.0, 1120.0) - 12 * (crossAxis - 1)) /
            crossAxis;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _items
                .map(
                  (item) => WishlistProductCard(
                    item: item,
                    width: cardWidth,
                    onRemove: () => setState(() => _items.remove(item)),
                    onAddToCart: () => _addToCart(item),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  void _addToCart(WishlistItem item) {
    Get.find<AuthController>().requireAuthentication(
      onAuthenticated: () {
        Get.showSnackbar(
          GetSnackBar(
            message: '${item.name} added to cart.',
            backgroundColor: AppColors.successGreen,
            duration: const Duration(seconds: 2),
          ),
        );
      },
    );
  }
}
