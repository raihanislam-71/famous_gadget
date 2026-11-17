import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../breakpoints.dart';
import '../../models/product.dart';
import '../navigation/app_navigation.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/product_card.dart';
import '../widgets/responsive_product_grid.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<Product> _items = [
    Product.demoForId('sony-xm5'),
    Product.demoForId('anker-r50i'),
    Product.demoForId('haylou-watch'),
    Product.demoForId('a4tech-keyboard'),
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
    final showWebHeader = kIsWeb && MediaQuery.sizeOf(context).width >= 1100;

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: showWebHeader ? 0 : null,
      titleSpacing: showWebHeader ? webHeaderAlignedTitleSpacing(context) : 16,
      title: Text(
        'My Wishlist (${_items.length})',
        style: AppTextStyles.h2.copyWith(fontSize: 18),
      ),
      leading: showWebHeader
          ? const SizedBox.shrink()
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: ResponsiveProductGrid(
        itemCount: _items.length,
        itemBuilder: _buildWishlistProduct,
      ),
    );
  }

  Widget _buildWishlistProduct(BuildContext context, int index) {
    final product = _items[index];
    return Stack(
      fit: StackFit.expand,
      children: [
        ProductCard(product: product),
        Positioned(
          top: 8,
          right: 8,
          child: Semantics(
            button: true,
            label: 'Remove ${product.name} from wishlist',
            child: Material(
              color: Theme.of(context).colorScheme.surface,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => setState(() => _items.removeAt(index)),
                child: const SizedBox(
                  width: 32,
                  height: 32,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                    size: 19,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
