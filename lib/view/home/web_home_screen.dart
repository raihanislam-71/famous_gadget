import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../models/product.dart';
import '../navigation/app_navigation.dart';
import '../navigation/web_site_header.dart';
import '../utils/app_colors.dart';
import '../utils/assets_path.dart';
import '../category/category_screen.dart';
import '../category/product_by_category_screen.dart';
import '../category/sub_category_screen.dart';
import '../product_details/product_details_screen.dart';

class WebHomeScreen extends StatelessWidget {
  const WebHomeScreen({super.key});

  static const _categories = [
    _WebCategory('Smart Watch', '86', AssetsPath.smartWatch, 'Smart Watch'),
    _WebCategory('Security Camera', '45', AssetsPath.camera, 'Security'),
    _WebCategory('Gimbal', '32', AssetsPath.gimbal, 'Gimbal'),
    _WebCategory('Accessories', '210', AssetsPath.phone, 'Accessories'),
    _WebCategory('Projector', '28', AssetsPath.projector, 'Projector'),
    _WebCategory('Microphone', '54', AssetsPath.gimbal, 'Microphone'),
    _WebCategory('Router', '38', AssetsPath.projector, 'Router'),
    _WebCategory('Tablets', '12', AssetsPath.phone, 'Tablet'),
  ];

  static const _featured = [
    _WebProduct(
      'Anker Soundcore R50i True Wireless Earbuds',
      1999,
      2499,
      '4.8',
      '210',
      'featured_earbuds.jpg',
      'anker-r50i',
    ),
    _WebProduct(
      'Haylou Solar Lite Smart Watch with SpO2',
      2799,
      3599,
      '4.7',
      '89',
      'featured_watch.jpg',
      'haylou-watch',
    ),
    _WebProduct(
      'DJI Osmo Mobile 6 Smartphone Gimbal',
      13499,
      15000,
      '4.9',
      '135',
      'featured_gimbal.jpg',
      'dji-osmo',
    ),
    _WebProduct(
      'Sony WH-1000XM5 Noise Cancelling Headphones',
      32500,
      45000,
      '4.9',
      '342',
      'featured_headphones.jpg',
      'sony-xm5',
    ),
  ];

  static const _bestSellers = [
    _WebProduct(
      'OnePlus Nord CE 3 Lite 5G (8GB/256GB)',
      24499,
      27900,
      '4.9',
      '340',
      'bestseller_phone.jpg',
      'oneplus-nord',
    ),
    _WebProduct(
      'A4Tech Bloody B820R Mechanical Keyboard',
      4200,
      5000,
      '4.6',
      '120',
      'bestseller_keyboard.jpg',
      'a4tech-keyboard',
    ),
    _WebProduct(
      'Xiaomi Mi TV Box S 2nd Gen 4K Ultra HD',
      5699,
      6500,
      '4.8',
      '412',
      'bestseller_tvbox.jpg',
      'xiaomi-tv-box',
    ),
    _WebProduct(
      'TP-Link Archer C6 MU-MIMO Router',
      2399,
      2800,
      '4.7',
      '512',
      'bestseller_router.jpg',
      'tp-link-router',
    ),
  ];

  static const _newArrivals = [
    _WebProduct(
      'Xiaomi Pad 6 (8GB/256GB)',
      36500,
      39000,
      '4.8',
      '45',
      'new_phone.jpg',
      'xiaomi-pad',
    ),
    _WebProduct(
      'Realme Buds T300 with 30dB ANC',
      2850,
      3500,
      '4.6',
      '28',
      'new_earbuds.jpg',
      'realme-buds',
    ),
    _WebProduct(
      'BoyaLink Wireless Dual Lavalier Microphone',
      9499,
      11000,
      '4.7',
      '19',
      'new_lavalier.jpg',
      'boya-mic',
    ),
    _WebProduct(
      'Wanbo T2 Max Smart Full HD Projector',
      16499,
      18999,
      '4.5',
      '67',
      'new_projector.jpg',
      'wanbo-projector',
    ),
  ];

  static const _recommended = [
    _WebProduct(
      'Logitech C922 Pro Stream Webcam',
      10500,
      12500,
      '4.8',
      '94',
      'recommended_webcam.jpg',
      'logitech-webcam',
    ),
    _WebProduct(
      'Anker PowerCore 24K 140W Power Bank',
      14200,
      16500,
      '4.9',
      '210',
      'recommended_powerbank.jpg',
      'anker-powercore',
    ),
    _WebProduct(
      'Samsung Galaxy Tab S9 FE',
      49500,
      55000,
      '4.8',
      '120',
      'recommended_tablet.jpg',
      'samsung-tab',
    ),
    _WebProduct(
      'Aventho Wireless Headset',
      15499,
      19500,
      '4.7',
      '34',
      'recommended_headset.jpg',
      'aventho-headset',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const WebSiteHeader(),
            _buildHero(context),
            _buildCategorySection(context),
            _buildProductsSection(
              context,
              title: 'Featured Products',
              subtitle: 'Highly-rated authentic tech gear selected for you',
              products: _featured,
            ),
            _buildProductsSection(
              context,
              title: 'Best Sellers',
              subtitle: 'Our overall top-selling electronic essentials',
              products: _bestSellers,
              shaded: true,
            ),
            _buildHotDeals(context),
            _buildPromoBanners(context),
            _buildProductsSection(
              context,
              title: 'New Arrivals',
              subtitle:
                  'The latest smart gadgets hitting our shelves this week',
              products: _newArrivals,
            ),
            _buildProductsSection(
              context,
              title: 'Recommended For You',
              subtitle: 'Tailored gadgets matching your interests',
              products: _recommended,
              shaded: true,
            ),
            _buildTrustSection(context),
            _buildNewsletter(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final compact = width < 720;
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final hero = Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: compact ? 410 : 420),
          padding: EdgeInsets.all(compact ? 24 : 48),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? const [Color(0xFF0B1220), Color(0xFF7C2D12)]
                  : const [Color(0xFFFFF8F2), Color(0xFFFFE7D2)],
            ),
            borderRadius: BorderRadius.circular(compact ? 20 : 32),
          ),
          child: Flex(
            direction: compact ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: compact ? 0 : 6,
                fit: compact ? FlexFit.loose : FlexFit.tight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white : AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'WINTER BLOCKBUSTER DEAL',
                        style: TextStyle(
                          color: isDark ? AppColors.primary : Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Up to 40% Off on Smart Watches',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontSize: compact ? 34 : 48,
                        height: 1.12,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : AppColors.navyDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Upgrade your lifestyle with original premium gadgets. '
                      'Official brand warranty with fast cash on delivery across Bangladesh.',
                      style: TextStyle(
                        color: isDark
                            ? Colors.white70
                            : AppColors.secondaryText,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      children: [
                        FilledButton(
                          onPressed: _openCategories,
                          child: const Text('Shop Collection Now'),
                        ),
                        OutlinedButton(
                          onPressed: () => _openProducts('Hot Deals'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: isDark
                                ? Colors.white
                                : AppColors.navyDark,
                            side: BorderSide(
                              color: isDark ? Colors.white : AppColors.navyDark,
                            ),
                          ),
                          child: const Text('View All Deals'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!compact) const SizedBox(width: 24),
              Flexible(
                flex: compact ? 0 : 4,
                fit: compact ? FlexFit.loose : FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.only(top: compact ? 20 : 0),
                  child: Image.asset(
                    AssetsPath.webHeroWatch,
                    height: compact ? 210 : 330,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.watch_outlined,
                      size: 180,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

        return Padding(
          padding: EdgeInsets.fromLTRB(
            width > 1360 ? 80 : 24,
            32,
            width > 1360 ? 80 : 24,
            32,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: hero,
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategorySection(BuildContext context) {
    return _SectionBand(
      child: _WebContent(
        child: Column(
          children: [
            _WebSectionHeading(
              title: 'Shop by Category',
              subtitle:
                  'Explore our handpicked collections of trending tech gadgets',
              onSeeAll: _openCategories,
            ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth < 560
                    ? 2
                    : constraints.maxWidth < 900
                    ? 4
                    : 8;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 146,
                  ),
                  itemBuilder: (context, index) =>
                      _WebCategoryCard(category: _categories[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsSection(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<_WebProduct> products,
    bool shaded = false,
  }) {
    return _SectionBand(
      shaded: shaded,
      child: _WebContent(
        child: Column(
          children: [
            _WebSectionHeading(
              title: title,
              subtitle: subtitle,
              onSeeAll: () => _openProducts(title),
            ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth < 560
                    ? 2
                    : constraints.maxWidth < 900
                    ? 3
                    : 4;
                final aspectRatio = columns == 2 ? 0.62 : 0.96;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: aspectRatio,
                  ),
                  itemBuilder: (context, index) =>
                      _WebProductCard(product: products[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHotDeals(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return _WebContent(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : AppColors.softPeach,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isDark ? const Color(0xFF334155) : const Color(0xFFFFE0C7),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 680;
              final details = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Tag(
                    text: 'LIMITED TIME FLASH SALE',
                    background: AppColors.primary,
                    foreground: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Hot Weekly Gadget Deals',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: compact ? 26 : 36,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Hurry up! Grab your favorite gadgets before they sell out. '
                    'Stock runs out fast.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  const Wrap(
                    spacing: 8,
                    children: [
                      _CountdownUnit(number: '02', label: 'Days'),
                      _CountdownUnit(number: '14', label: 'Hrs'),
                      _CountdownUnit(number: '45', label: 'Mins'),
                      _CountdownUnit(number: '12', label: 'Secs'),
                    ],
                  ),
                ],
              );
              const offer = _WebProductCard(
                product: _WebProduct(
                  'Arlo Pro 5 Smart 4K Camera',
                  18500,
                  24000,
                  '4.8',
                  '52',
                  'hot_camera.jpg',
                  'arlo-pro-5',
                ),
              );
              if (compact) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    details,
                    const SizedBox(height: 20),
                    const SizedBox(height: 280, child: offer),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(flex: 2, child: details),
                  const SizedBox(width: 24),
                  const SizedBox(width: 280, height: 280, child: offer),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPromoBanners(BuildContext context) {
    return _WebContent(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 28),
        child: LayoutBuilder(
          builder: (context, constraints) {
            const banners = [
              _PromoCard(
                title: 'Free Shipping Nationwide',
                subtitle: 'On all authentic gadget orders above ৳5,000.',
                icon: Icons.local_shipping_outlined,
              ),
              _PromoCard(
                title: 'Safe Cash on Delivery',
                subtitle: 'Pay only after inspecting your premium gadgets.',
                icon: Icons.verified_user_outlined,
              ),
            ];
            return Flex(
              direction: constraints.maxWidth < 620
                  ? Axis.vertical
                  : Axis.horizontal,
              children: [
                for (var index = 0; index < banners.length; index++) ...[
                  if (index > 0)
                    SizedBox(
                      width: constraints.maxWidth < 620 ? 12 : 16,
                      height: constraints.maxWidth < 620 ? 12 : 0,
                    ),
                  Flexible(
                    flex: constraints.maxWidth < 620 ? 0 : 1,
                    fit: constraints.maxWidth < 620
                        ? FlexFit.loose
                        : FlexFit.tight,
                    child: banners[index],
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTrustSection(BuildContext context) {
    const trustItems = [
      (
        'Cash on Delivery BD',
        'Inspect your package first, then pay',
        Icons.local_shipping_outlined,
      ),
      (
        'Genuine Warranty',
        '100% authentic brand replacements',
        Icons.verified_outlined,
      ),
      ('7-Day Returns', 'Hassle-free product exchange policy', Icons.sync),
      (
        'Premium Support',
        'Professional 24/7 client helpline',
        Icons.support_agent,
      ),
    ];
    return _SectionBand(
      shaded: true,
      child: _WebContent(
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 24,
          runSpacing: 18,
          children: trustItems
              .map(
                (item) => SizedBox(
                  width: 255,
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(item.$3, color: AppColors.primary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.$1,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.$2,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildNewsletter(BuildContext context) {
    return const _WebContent(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: _NewsletterSignup(),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      color: const Color(0xFF0B1220),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 48,
                runSpacing: 32,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(AssetsPath.appLogo, width: 40),
                            const SizedBox(width: 8),
                            Image.asset(
                              AssetsPath.appName,
                              width: 112,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Shop 363 #Level 3, Computer City Center, '
                          '(Multiplan) New Elephant Road, Dhaka-1205, Bangladesh.',
                          style: TextStyle(color: Colors.white70, height: 1.5),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Download App',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const _FooterLinks(
                    title: 'Contact',
                    links: [
                      '+8801934777923',
                      '+8801934777924',
                      '+8801934777925',
                      'famousgadget2022@gmail.com',
                    ],
                    textColor: Colors.white70,
                  ),
                  _FooterLinks(
                    title: 'My Account',
                    links: const ['My Account', 'Order History'],
                    textColor: Colors.white70,
                    onTap: (label) => AppRoutes.to<void>(
                      route: label == 'Order History'
                          ? AppRoutes.orders
                          : AppRoutes.account,
                      arguments: {'isPreview': true},
                      mobileBuilder: () => const SizedBox.shrink(),
                    ),
                  ),
                  const _FooterLinks(
                    title: 'Useful Links',
                    links: [
                      'Brands',
                      'Privacy Policy',
                      'Refund and Return Policy',
                      'Terms & Conditions',
                      'EMI Information',
                      'Contact Us',
                    ],
                    textColor: Colors.white70,
                  ),
                ],
              ),
              const SizedBox(height: 36),
              Divider(color: Colors.white.withValues(alpha: 0.16)),
              const SizedBox(height: 14),
              const Text(
                '© 2026 Famous Gadget Bangladesh. All rights reserved.',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openCategories() {
    AppRoutes.to<void>(
      route: AppRoutes.categories,
      mobileBuilder: () => const CategoryScreen(),
    );
  }

  void _openProducts(String categoryName) {
    AppRoutes.to<void>(
      route: AppRoutes.products,
      arguments: {'categoryName': categoryName},
      mobileBuilder: () => ProductByCategoryScreen(categoryName: categoryName),
    );
  }
}

class _WebContent extends StatelessWidget {
  const _WebContent({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1280),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width > 1360 ? 0 : 24,
            vertical: 36,
          ),
          child: child,
        ),
      ),
    );
  }
}

class _SectionBand extends StatelessWidget {
  const _SectionBand({required this.child, this.shaded = false});

  final Widget child;
  final bool shaded;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: shaded
          ? (Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF111827)
                : const Color(0xFFF3F5FA))
          : Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }
}

class _WebSectionHeading extends StatelessWidget {
  const _WebSectionHeading({
    required this.title,
    required this.subtitle,
    required this.onSeeAll,
  });

  final String title;
  final String subtitle;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontSize: 28, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          if (constraints.maxWidth > 420)
            TextButton(
              onPressed: onSeeAll,
              child: const Row(
                children: [
                  Text('See all'),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right, size: 18),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _WebCategory {
  const _WebCategory(this.name, this.count, this.image, this.routeName);

  final String name;
  final String count;
  final String image;
  final String routeName;
}

class _WebCategoryCard extends StatelessWidget {
  const _WebCategoryCard({required this.category});

  final _WebCategory category;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => AppRoutes.to<void>(
          route: AppRoutes.subCategory,
          arguments: {'categoryName': category.routeName},
          mobileBuilder: () =>
              SubCategoryScreen(categoryName: category.routeName),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(category.image, fit: BoxFit.contain),
              ),
              const SizedBox(height: 8),
              Text(
                category.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 2),
              Text(
                '${category.count} items',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WebProduct {
  const _WebProduct(
    this.name,
    this.price,
    this.originalPrice,
    this.rating,
    this.reviewCount,
    this.imageName,
    this.id,
  );

  final String name;
  final double price;
  final double originalPrice;
  final String rating;
  final String reviewCount;
  final String imageName;
  final String id;

  Product toProduct() => Product(
    id: id,
    name: name,
    price: price,
    originalPrice: originalPrice,
    description:
        'Authentic gadget with official warranty and cash on delivery.',
    specifications: const {},
  );
}

class _WebProductCard extends StatelessWidget {
  const _WebProductCard({required this.product});

  final _WebProduct product;

  @override
  Widget build(BuildContext context) {
    final imagePath = 'assets/images/figma_web/${product.imageName}';
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        onTap: () => AppRoutes.to<void>(
          route: AppRoutes.productDetails,
          arguments: {'productId': product.id},
          mobileBuilder: () => ProductDetailsScreen(productId: product.id),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(
                            color: AppColors.pageBackground,
                            child: const Icon(
                              Icons.devices_other,
                              size: 44,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: _Tag(
                        text: '-${_discountPercent()}%',
                        background: AppColors.primary,
                        foreground: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          product.rating,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${product.reviewCount})',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '৳${_formatPrice(product.price)}',
                                maxLines: 1,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '৳${_formatPrice(product.originalPrice)}',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color,
                                  fontSize: 11,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton.filled(
                          tooltip: 'Add to cart',
                          onPressed: () =>
                              Get.find<CartController>().addProduct(
                                product.toProduct(),
                                quantity: 1,
                                imagePath: imagePath,
                              ),
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(36, 36),
                            padding: EdgeInsets.zero,
                          ),
                          icon: const Icon(Icons.add, size: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _discountPercent() =>
      (100 - product.price / product.originalPrice * 100).round();

  String _formatPrice(double value) => value.toStringAsFixed(0);
}

class _Tag extends StatelessWidget {
  const _Tag({
    required this.text,
    required this.background,
    required this.foreground,
  });

  final String text;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: foreground,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _CountdownUnit extends StatelessWidget {
  const _CountdownUnit({required this.number, required this.label});

  final String number;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1220),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  const _PromoCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.45)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterLinks extends StatelessWidget {
  const _FooterLinks({
    required this.title,
    required this.links,
    required this.textColor,
    this.onTap,
  });

  final String title;
  final List<String> links;
  final Color textColor;
  final ValueChanged<String>? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          for (final link in links)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: onTap == null ? null : () => onTap!(link),
                child: Text(
                  link,
                  style: TextStyle(color: textColor, fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _NewsletterSignup extends StatefulWidget {
  const _NewsletterSignup();

  @override
  State<_NewsletterSignup> createState() => _NewsletterSignupState();
}

class _NewsletterSignupState extends State<_NewsletterSignup> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 700;
          final content = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Don't Miss Latest Tech Trends",
                style: Theme.of(context).textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                'Subscribe to get special discount vouchers, flash sale alerts, '
                'and reviews of the latest gadgets.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          );
          final form = Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email address',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: _subscribe,
                child: const Text('Subscribe'),
              ),
            ],
          );
          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [content, const SizedBox(height: 20), form],
            );
          }
          return Row(
            children: [
              Expanded(child: content),
              const SizedBox(width: 28),
              SizedBox(width: 456, child: form),
            ],
          );
        },
      ),
    );
  }

  void _subscribe() {
    final email = _emailController.text.trim();
    if (!email.contains('@') || !email.contains('.')) {
      Get.snackbar('Invalid email', 'Enter a valid email address.');
      return;
    }
    Get.snackbar(
      'Thanks for subscribing',
      'Newsletter subscriptions are demo-only.',
    );
  }
}
