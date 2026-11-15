import 'package:famous_gadget/models/wishlist_item_model.dart';
import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:famous_gadget/view/utils/app_text_styles.dart';
import 'package:famous_gadget/view/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class WishlistProductCard extends StatelessWidget {
  const WishlistProductCard({
    super.key,
    required this.item,
    required this.width,
    required this.onRemove,
    required this.onAddToCart,
  });

  final WishlistItem item;
  final double width;
  final VoidCallback onRemove;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
                  right: 0,
                  child: Semantics(
                    button: true,
                    label: 'Remove ${item.name} from wishlist',
                    child: SizedBox(
                      width: 28,
                      height: 28,
                      child: Material(
                        color: Theme.of(context).colorScheme.surface,
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
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
              height: 1.2,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.price,
            style: AppTextStyles.badge.copyWith(
              fontSize: 16,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            height: 34,
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
                        width: 18,
                        height: 18,
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          size: 17,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Add to Cart',
                        style: AppTextStyles.badge.copyWith(
                          fontSize: 12,
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
