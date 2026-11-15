import 'package:famous_gadget/view/utils/assets_path.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({super.key});

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double carouselHeight = screenWidth < 600 ? 180 : 220;

    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: carouselHeight,
            viewportFraction: 1.0,
            onPageChanged: ((index, reason) {
              _selectedIndex.value = index;
            }),
          ),
          items: const [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return _buildBannerCardDesign(screenWidth);
              },
            );
          }).toList(),
        ),
        ValueListenableBuilder(
          valueListenable: _selectedIndex,
          builder: (context, currentIndex, _) {
            return Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                      height: 8,
                      width: 8,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: currentIndex == i
                            ? Colors.white
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

  Widget _buildBannerCardDesign(double screenWidth) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF0B1220), Color(0xFFFF6A00)],
                ),
              ),
            ),
          ),
          // Content Row
          Padding(
            padding: EdgeInsets.all(screenWidth < 380 ? 16 : 24),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "WINTER DEAL",
                          style: TextStyle(
                            fontSize: screenWidth < 380 ? 10 : 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.themeColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Up to 40% Off Smart Watches",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth < 380 ? 16 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.themeColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Shop Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth < 380 ? 12 : 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: AssetImage(AssetsPath.bannerImage),
                        fit: BoxFit.contain,
                      ),
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

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }
}
