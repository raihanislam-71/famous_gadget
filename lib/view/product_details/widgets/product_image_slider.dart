import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/assets_path.dart';

class ProductImageSlider extends StatefulWidget {
  const ProductImageSlider({
    super.key,
    required this.productId,
    this.imagePath = AssetsPath.productImage,
    this.imagePaths,
    this.selectedImagePath,
    this.onImageChanged,
    this.mobileStyle = false,
    this.badgeText,
    this.badgeColor,
  });

  final String productId;
  final String imagePath;
  final List<String>? imagePaths;
  final String? selectedImagePath;
  final ValueChanged<String>? onImageChanged;
  final bool mobileStyle;
  final String? badgeText;
  final Color? badgeColor;

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  late int _currentIndex;

  List<String> get _images => widget.imagePaths?.isNotEmpty == true
      ? widget.imagePaths!
      : [widget.imagePath];

  int get _selectedIndex {
    final index = _images.indexOf(widget.selectedImagePath ?? widget.imagePath);
    return index < 0 ? 0 : index;
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = _selectedIndex;
  }

  @override
  void didUpdateWidget(covariant ProductImageSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedImagePath != widget.selectedImagePath) {
      _currentIndex = _selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.sizeOf(context).width;

    final double imageHeight = widget.mobileStyle
        ? (screenWidth * 0.76).clamp(260.0, 340.0)
        : screenWidth >= 1100
        ? 420
        : screenWidth > 600
        ? 340
        : screenWidth < 350
        ? 200
        : screenWidth * 0.70;
    final images = _images;

    return Container(
      height: imageHeight,
      width: double.infinity,
      decoration: widget.mobileStyle
          ? BoxDecoration(color: theme.colorScheme.surface)
          : BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.5,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: theme.dividerColor.withValues(alpha: 0.5),
              ),
            ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: imageHeight,
              viewportFraction: 1,
              initialPage: _currentIndex,
              enableInfiniteScroll: images.length > 1,
              autoPlay: false,
              onPageChanged: (index, reason) {
                setState(() => _currentIndex = index);
                widget.onImageChanged?.call(images[index]);
              },
            ),
            items: List.generate(
              images.length,
              (index) => Padding(
                padding: EdgeInsets.all(widget.mobileStyle ? 18 : 24),
                child: Hero(
                  tag:
                      'product_image_${widget.productId.isEmpty ? "default" : widget.productId}_$index',
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => Center(
                      child: Icon(
                        Icons.devices_other,
                        size: widget.mobileStyle ? 72 : 96,
                        color: AppColors.primary.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (widget.badgeText != null)
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: (widget.badgeColor ?? AppColors.primary),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: (widget.badgeColor ?? AppColors.primary)
                          .withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  widget.badgeText!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          if (widget.mobileStyle && images.length > 1)
            Positioned(
              bottom: 2,
              child: Row(
                children: List.generate(
                  images.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: index == _currentIndex ? 8 : 6,
                    height: index == _currentIndex ? 8 : 6,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: index == _currentIndex
                          ? AppColors.primary
                          : theme.colorScheme.onSurfaceVariant.withValues(
                              alpha: 0.35,
                            ),
                      shape: BoxShape.circle,
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
