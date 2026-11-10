import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/assets_path.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({
    super.key,
    required this.productId,
    this.imagePath = AssetsPath.productImage,
    this.badgeText,
    this.badgeColor,
  });

  final String productId;
  final String imagePath;
  final String? badgeText;
  final Color? badgeColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double screenWidth = MediaQuery.of(context).size.width;

    double imageHeight = screenWidth * 0.70;
    if (screenWidth >= 1100) {
      imageHeight = 440;
    } else if (screenWidth > 600) {
      imageHeight = 360;
    } else if (screenWidth < 350) {
      imageHeight = 220;
    }

    return Container(
      height: imageHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.5)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Hero(
              tag: 'product_image_${productId.isEmpty ? "default" : productId}',
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => Center(
                  child: Icon(
                    Icons.devices_other,
                    size: 96,
                    color: AppColors.primary.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ),
          ),
          if (badgeText != null)
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: (badgeColor ?? AppColors.primary),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: (badgeColor ?? AppColors.primary).withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  badgeText!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
