import 'package:bdcalling_class/view/widgets/recommended_for_you_grid_card.dart';
import 'package:bdcalling_class/view/widgets/section_header.dart';
import 'package:flutter/material.dart';

import '../utils/assets_path.dart';
import '../widgets/hot_deal_grid_card.dart';
import 'widgets/home_banner_slider.dart';
import 'widgets/horizontal_category_list_view.dart';
import 'widgets/horizontal_product_list_view.dart';
import '../widgets/promo_banner.dart';
import '../widgets/responsive_product_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bannerHeight = screenWidth > 600 ? 250.0 : screenWidth * 0.45;

    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: const Color(0xFFF3F5FA),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(
                height: bannerHeight,
                width: double.infinity,
                child: const HomeBannerSlider(),
              ),
              const SizedBox(height: 16),
              SectionHeader(title: 'Category', onTap: () {}),
              const SizedBox(height: 16),
              _buildCategoriesSection(),
              const SizedBox(height: 16),
              SectionHeader(title: 'Featured Product', onTap: () {}),
              const SizedBox(height: 16),
              _buildFeaturedProductSection(),
              const SizedBox(height: 16),
              SectionHeader(title: 'Best Sellers', onTap: () {}),
              const SizedBox(height: 16),
              _buildFeaturedProductSection(),
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
              ),
              const SizedBox(height: 16),
              const PromoBanner(
                title: 'New Arrivals',
                description: 'Explore the latest tech trends & tools for your daily life',
                buttonLabel: 'Explore',
                colors: [Color(0xFF0B1220), Color(0xFF1D2C40)],
                buttonForeground: Color(0xFF0B1220),
              ),
              const SizedBox(height: 16),
              SectionHeader(title: 'Recommended For You', onTap: () {}),
              const SizedBox(height: 16),
              _buildRecommendedForYouSection(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
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
    return const RecommendedForYouGridCard();
  }

  static Widget _buildHotDealProduct(BuildContext context, int index) {
    return const HotDealGridCard();
  }

  Widget _buildFeaturedProductSection() {
    return const SizedBox(height: 200, child: HorizontalProductListView());
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Row(
        children: [
          Image.asset(AssetsPath.appLogo),
          Image.asset(AssetsPath.appName, color: Colors.black),
        ],
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search, size: 32)),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications, size: 32),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return SizedBox(height: 110, child: HorizontalCategoriesListView());
  }
}
