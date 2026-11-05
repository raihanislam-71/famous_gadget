import 'package:bdcalling_class/presentation/ui/utils/assets_path.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class ProductImageSlider extends StatefulWidget {
  const ProductImageSlider({super.key, required this.productId});

  final String productId;

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    double dynamicHeight = screenWidth * 0.55;

    if (screenWidth > 600) {
      dynamicHeight = 300;
    } else if (screenWidth < 350) {
      dynamicHeight = 180;
    }

    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: dynamicHeight,
            viewportFraction: 1,
            onPageChanged: ((index, reason) {
              _selectedIndex.value = index;
            }),
          ),
          items: const [1, 2, 3, 4, 5].map((index) {
            return Builder(
              builder: (BuildContext context) {
                return _buildBannerCardDesign(index);
              },
            );
          }).toList(),
        ),

        ValueListenableBuilder(
          valueListenable: _selectedIndex,
          builder: (context, currentIndex, _) {
            return Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                      height: 12,
                      width: 12,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: currentIndex == i
                            ? AppColors.themeColor
                            : Colors.white54,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 0.5,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBannerCardDesign(int index) {
    Widget currentWidget = Container(
      margin: const EdgeInsets.symmetric(horizontal:8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        image: const DecorationImage(
          image: AssetImage(AssetsPath.productImage),
          fit: BoxFit.scaleDown,
        ),
      ),
    );

    if (index == 1) {
      return Hero(
        tag: 'product_image_${widget.productId}',
        child: currentWidget,
      );
    }

    return currentWidget;
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }
}
