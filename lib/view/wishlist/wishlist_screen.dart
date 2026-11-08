import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/assets_path.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<_WishlistItem> _items = [
    const _WishlistItem(
      name: 'Sony WH-1000XM5',
      price: '৳32,500',
      imagePath: AssetsPath.wishlistSonyImage,
    ),
    const _WishlistItem(
      name: 'Anker Soundcore R50i',
      price: '৳1,999',
      imagePath: AssetsPath.wishlistAnkerImage,
    ),
    const _WishlistItem(
      name: 'Haylou Solar Lite',
      price: '৳2,799',
      imagePath: AssetsPath.wishlistHaylouImage,
    ),
    const _WishlistItem(
      name: 'A4Tech Bloody B820R',
      price: '৳4,200',
      imagePath: AssetsPath.wishlistA4TechImage,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.pageBackground,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.navyDark,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: AppColors.surface,
          shape: const Border(bottom: BorderSide(color: AppColors.border)),
          toolbarHeight: 60,
          leadingWidth: 52,
          titleSpacing: 0,
          leading: IconButton(
            tooltip: 'Back',
            onPressed: Get.back<void>,
            icon: SvgPicture.asset(AssetsPath.wishlistBackArrow),
          ),
          title: Text(
            'My Wishlist (${_items.length})',
            style: AppTextStyles.h2.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: _items.isEmpty
            ? Center(
                child: Text(
                  'Your wishlist is empty',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  final contentWidth = constraints.maxWidth - 32;
                  final cardWidth = contentWidth < 336
                      ? (contentWidth - 12) / 2
                      : 162.0;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        for (final item in _items)
                          _WishlistProductCard(
                            item: item,
                            width: cardWidth,
                            onRemove: () => _removeItem(item),
                            onAddToCart: () => _addToCart(item),
                          ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  void _removeItem(_WishlistItem item) {
    setState(() => _items.remove(item));
  }

  void _addToCart(_WishlistItem item) {
    Get.find<AuthController>().requireAuthentication(
      onAuthenticated: () {
        Get.showSnackbar(
          GetSnackBar(
            message: '${item.name} added to cart.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.successGreen,
            duration: const Duration(seconds: 2),
            margin: const EdgeInsets.all(10),
            borderRadius: 8,
          ),
        );
      },
    );
  }
}

class _WishlistItem {
  const _WishlistItem({
    required this.name,
    required this.price,
    required this.imagePath,
  });

  final String name;
  final String price;
  final String imagePath;
}

class _WishlistProductCard extends StatelessWidget {
  const _WishlistProductCard({
    required this.item,
    required this.width,
    required this.onRemove,
    required this.onAddToCart,
  });

  final _WishlistItem item;
  final double width;
  final VoidCallback onRemove;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.navyDark.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(item.imagePath, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Semantics(
                    button: true,
                    label: 'Remove ${item.name} from wishlist',
                    child: SizedBox(
                      width: 28,
                      height: 28,
                      child: Material(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        child: InkWell(
                          onTap: onRemove,
                          borderRadius: BorderRadius.circular(14),
                          child: Center(
                            child: SvgPicture.asset(AssetsPath.wishlistHeart),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body.copyWith(
              fontSize: 13,
              height: 1.2,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.price,
            style: AppTextStyles.badge.copyWith(
              fontSize: 15,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            height: 27,
            child: Material(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: onAddToCart,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 12,
                        height: 12,
                        child: FittedBox(
                          child: SvgPicture.asset(AssetsPath.wishlistCart),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Add to Cart',
                        style: AppTextStyles.badge.copyWith(
                          fontSize: 11,
                          color: AppColors.surface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
