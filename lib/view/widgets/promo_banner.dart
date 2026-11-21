import 'package:famous_gadget/breakpoints.dart';
import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({
    super.key,
    this.title = 'Up to 40% Off on Smart Watches',
    this.description =
        'Upgrade your lifestyle with original premium gadgets. Official brand warranty with fast cash on delivery across Bangladesh.',
    this.buttonLabel = 'Shop Now',
    this.imagePath = 'assets/images/figma_web/hero_watch.jpg',
    this.colors = const [Colors.deepOrange, Colors.amber],
    this.buttonForeground = Colors.deepOrange,
    this.onPressed,
    this.height,
  });

  final String title;
  final String description;
  final String buttonLabel;
  final String imagePath;
  final List<Color> colors;
  final Color buttonForeground;
  final VoidCallback? onPressed;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;
    final isTablet = context.isTablet;

    final double bannerHeight = height ??
        (isDesktop ? 280.0 : (isTablet ? 220.0 : 180.0));
    final double titleSize = isDesktop ? 30 : (isTablet ? 24 : 18);
    final double subtitleSize = isDesktop ? 15 : (isTablet ? 13 : 12);
    final double imageWidth = isDesktop ? 260 : (isTablet ? 180 : 100);
    final double imageHeight = isDesktop ? 220 : (isTablet ? 160 : 100);

    return Container(
      height: bannerHeight,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 36 : (isTablet ? 24 : 16),
        vertical: isDesktop ? 28 : (isTablet ? 20 : 16),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: colors,
        ),
        borderRadius: BorderRadius.circular(isDesktop ? 24 : 18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
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
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: subtitleSize,
                    color: Colors.white70,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: isDesktop ? 16 : 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: buttonForeground,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(isDesktop ? 12 : 8),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 24 : (isTablet ? 18 : 14),
                      vertical: isDesktop ? 12 : (isTablet ? 9 : 8),
                    ),
                  ),
                  onPressed: onPressed ?? () {},
                  child: Text(
                    buttonLabel,
                    style: TextStyle(
                      color: buttonForeground,
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
              imagePath,
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
                  size: isDesktop ? 50 : 36,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
