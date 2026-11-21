import 'package:carousel_slider/carousel_slider.dart';
import 'package:famous_gadget/breakpoints.dart';
import 'package:flutter/material.dart';

class BannerItem {
  final String title;
  final String subtitle;
  final String imagePath;
  final List<Color> colors;
  final Color buttonColor;
  final String buttonText;
  final VoidCallback? onTap;

  const BannerItem({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.colors,
    this.buttonColor = Colors.deepOrange,
    this.buttonText = 'Shop Now',
    this.onTap,
  });
}

class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({
    super.key,
    this.banners,
    this.height,
  });

  final List<BannerItem>? banners;
  final double? height;

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  static const List<BannerItem> _defaultBanners = [
    BannerItem(
      title: 'Up to 40% Off Smart Watches',
      subtitle:
          'Upgrade your lifestyle with original premium gadgets. Official warranty with cash on delivery.',
      imagePath: 'assets/images/figma_web/hero_watch.jpg',
      colors: [Colors.deepOrange, Colors.amber],
      buttonColor: Colors.deepOrange,
      buttonText: 'Shop Now',
    ),
    BannerItem(
      title: 'Authentic Audio & Earbuds',
      subtitle:
          'Enjoy rich sound and deep bass with premium earbuds for your daily life.',
      imagePath: 'assets/images/figma_web/featured_earbuds.jpg',
      colors: [Color(0xFF0B1220), Color(0xFFFF6A00)],
      buttonColor: Color(0xFFFF6A00),
      buttonText: 'Explore',
    ),
    BannerItem(
      title: 'Premium Noise Cancelling',
      subtitle:
          'Experience pure music and crystal clear calls with Sony WH-1000XM5.',
      imagePath: 'assets/images/figma_web/featured_headphones.jpg',
      colors: [Color(0xFF1E293B), Color(0xFF475569)],
      buttonColor: Color(0xFF1E293B),
      buttonText: 'Claim Now',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final banners = widget.banners ?? _defaultBanners;
    final isDesktop = context.isDesktop;
    final isTablet = context.isTablet;

    // Responsive height: Mobile = 190, Tablet = 280, Desktop/Web = 380
    final double sliderHeight = widget.height ??
        (isDesktop
            ? 380.0
            : (isTablet ? 280.0 : 190.0));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: sliderHeight,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 600),
            autoPlayCurve: Curves.easeInOut,
            onPageChanged: (index, reason) {
              _selectedIndex.value = index;
            },
          ),
          items: banners.map((banner) {
            return _buildBannerCard(context, banner);
          }).toList(),
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder<int>(
          valueListenable: _selectedIndex,
          builder: (context, currentIndex, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(banners.length, (index) {
                final isSelected = currentIndex == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: isDesktop ? 8 : 6,
                  width: isSelected ? (isDesktop ? 22 : 18) : (isDesktop ? 8 : 6),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.deepOrange
                        : Colors.grey.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBannerCard(BuildContext context, BannerItem banner) {
    final isDesktop = context.isDesktop;
    final isTablet = context.isTablet;

    final double titleSize = isDesktop ? 32 : (isTablet ? 24 : 18);
    final double subtitleSize = isDesktop ? 16 : (isTablet ? 14 : 12);
    final double imageWidth = isDesktop ? 290 : (isTablet ? 190 : 100);
    final double imageHeight = isDesktop ? 270 : (isTablet ? 180 : 100);

    final EdgeInsets padding = isDesktop
        ? const EdgeInsets.symmetric(horizontal: 36, vertical: 28)
        : (isTablet
            ? const EdgeInsets.symmetric(horizontal: 24, vertical: 20)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 14));

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: banner.colors,
        ),
        borderRadius: BorderRadius.circular(isDesktop ? 24 : 18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  banner.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: titleSize,
                    color: Colors.white,
                    height: 1.15,
                  ),
                ),
                SizedBox(height: isDesktop ? 8 : 4),
                Text(
                  banner.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: subtitleSize,
                    color: Colors.white70,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: isDesktop ? 18 : 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: banner.buttonColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(isDesktop ? 12 : 8),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 24 : (isTablet ? 18 : 14),
                      vertical: isDesktop ? 12 : (isTablet ? 9 : 8),
                    ),
                  ),
                  onPressed: banner.onTap ?? () {},
                  child: Text(
                    banner.buttonText,
                    style: TextStyle(
                      color: banner.buttonColor,
                      fontWeight: FontWeight.w700,
                      fontSize: isDesktop ? 16 : (isTablet ? 14 : 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(isDesktop ? 20 : 14),
            child: Image.asset(
              banner.imagePath,
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: imageWidth,
                height: imageHeight,
                color: Colors.white24,
                child: Icon(
                  Icons.devices_other,
                  color: Colors.white,
                  size: isDesktop ? 60 : 36,
                ),
              ),
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
