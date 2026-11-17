import 'package:famous_gadget/view/widgets/section_header.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product.dart';
import '../../controllers/theme_controller.dart';
import '../navigation/app_navigation.dart';
import '../navigation/web_site_header.dart';
import '../utils/assets_path.dart';
import '../widgets/product_card.dart';
import 'widgets/home_banner_slider.dart';
import 'widgets/horizontal_category_list_view.dart';
import '../widgets/promo_banner.dart';
import '../widgets/responsive_product_grid.dart';
import 'widgets/web/web_home_data.dart';
import 'widgets/web/web_footer.dart';
import 'widgets/web/web_newsletter_signup.dart';
import 'widgets/web/web_section_layout.dart';
import 'widgets/web/web_trust_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideLayout = MediaQuery.sizeOf(context).width >= 1100;

    return Scaffold(
      appBar: isWideLayout ? null : _buildAppBar(context),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          if (isWideLayout && !kIsWeb) const WebSiteHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: _buildHomeContent(isWideLayout),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent(bool isWideLayout) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final contentWidth = constraints.maxWidth > 1328
            ? 1280.0
            : constraints.maxWidth;
        final pagePadding = constraints.maxWidth >= 700 ? 24.0 : 12.0;

        return Center(
          child: SizedBox(
            width: contentWidth,
            child: Padding(
              padding: EdgeInsets.all(pagePadding),
              child: Column(
                children: [
                  const HomeBannerSlider(),
                  const SizedBox(height: 16),
                  SectionHeader(
                    title: 'Category',
                    onTap: () =>
                        AppRoutes.toNamed<void>(route: AppRoutes.categories),
                  ),
                  const SizedBox(height: 16),
                  _buildCategoriesSection(),
                  const SizedBox(height: 16),
                  SectionHeader(title: 'Featured Products', onTap: () {}),
                  const SizedBox(height: 16),
                  _buildHorizontalProductSection(WebHomeData.featured),
                  const SizedBox(height: 16),
                  SectionHeader(title: 'Best Sellers', onTap: () {}),
                  const SizedBox(height: 16),
                  _buildHorizontalProductSection(WebHomeData.bestSellers),
                  const SizedBox(height: 16),
                  SectionHeader(title: 'Hot Deals', onTap: () {}),
                  const SizedBox(height: 16),
                  _buildHotDealsGridViewSection(),
                  const SizedBox(height: 16),
                  const PromoBanner(
                    title: 'Free Shipping',
                    description: 'On all gadget orders over \$50',
                    buttonLabel: 'Claim Now',
                    colors: [Color(0xFFFF6A00), Color(0xFFFFA100)],
                    buttonForeground: Colors.orange,
                    imagePath: 'assets/images/banner-product-image.png',
                  ),
                  const SizedBox(height: 16),
                  const PromoBanner(
                    title: 'New Arrivals',
                    description: 'Explore the latest tech trends & tools for your daily life',
                    buttonLabel: 'Explore',
                    colors: [Color(0xFF0B1220), Color(0xFF1D2C40)],
                    buttonForeground: Color(0xFF0B1220),
                    imagePath: 'assets/images/figma_web/new_earbuds.jpg',
                  ),
                  const SizedBox(height: 16),
                  SectionHeader(title: 'Recommended For You', onTap: () {}),
                  const SizedBox(height: 16),
                  _buildRecommendedForYouSection(),
                  const SizedBox(height: 100),
                  if (isWideLayout) ...[
                    const WebSectionBand(
                      shaded: true,
                      child: WebWebContent(child: WebTrustSection()),
                    ),
                    const SizedBox(height: 24),
                    const WebWebContent(child: WebNewsletterSignup()),
                    const SizedBox(height: 24),
                    const WebFooter(),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecommendedForYouSection() {
    return const ResponsiveProductGrid(
      itemCount: 4,
      itemBuilder: _buildRecommendedProduct,
    );
  }

  Widget _buildHotDealsGridViewSection() {
    return const ResponsiveProductGrid(
      itemCount: 4,
      itemBuilder: _buildHotDealProduct,
    );
  }

  static Widget _buildRecommendedProduct(BuildContext context, int index) {
    return ProductCard(productId: '$index');
  }

  static Widget _buildHotDealProduct(BuildContext context, int index) {
    return ProductCard(productId: '${index + 4}');
  }

  Widget _buildHorizontalProductSection(List<Product> products) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth >= 1100
            ? 260.0
            : (constraints.maxWidth >= 700 ? 230.0 : 190.0);

        return SizedBox(
          height: 310,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) =>
                ProductCard(product: products[index], width: cardWidth),
            separatorBuilder: (_, _) => const SizedBox(width: 12),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isSmallScreen = screenWidth < 400;
    final logoWidth = isSmallScreen ? 112.0 : 148.0;
    final iconSize = isSmallScreen ? 21.0 : 24.0;

    return AppBar(
      backgroundColor: Get.theme.colorScheme.surface,
      foregroundColor: Get.theme.colorScheme.onSurface,
      surfaceTintColor: Get.theme.colorScheme.surface,
      automaticallyImplyLeading: false,
      titleSpacing: isSmallScreen ? 8 : 12,
      title: SizedBox(
        width: logoWidth,
        height: 34,
        child: Row(
          children: [
            Image.asset(
              AssetsPath.appLogo,
              width: isSmallScreen ? 30 : 36,
              height: 30,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Image.asset(
                AssetsPath.appName,
                color: Get.theme.colorScheme.onSurface,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
      actions: [
        _buildAppBarIconButton(
          icon: Icons.search,
          tooltip: 'Search',
          iconSize: iconSize,
        ),
        _buildAppBarIconButton(
          icon: Icons.notifications_none,
          tooltip: 'Notifications',
          iconSize: iconSize,
        ),
        GetBuilder<ThemeController>(
          builder: (controller) => IconButton(
            tooltip: controller.isDarkMode ? 'Light mode' : 'Dark mode',
            onPressed: controller.toggleTheme,
            constraints: const BoxConstraints.tightFor(width: 36, height: 40),
            padding: EdgeInsets.zero,
            icon: Icon(
              controller.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              size: iconSize,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBarIconButton({
    required IconData icon,
    required String tooltip,
    required double iconSize,
  }) {
    return IconButton(
      tooltip: tooltip,
      onPressed: () {},
      constraints: const BoxConstraints.tightFor(width: 36, height: 40),
      padding: EdgeInsets.zero,
      icon: Icon(icon, size: iconSize),
    );
  }

  Widget _buildCategoriesSection() {
    return SizedBox(height: 124, child: HorizontalCategoriesListView());
  }
}
