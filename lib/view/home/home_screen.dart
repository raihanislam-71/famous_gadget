import 'package:bdcalling_class/presentation/ui/widgets/recommended_for_you_grid_card.dart';
import 'package:bdcalling_class/presentation/ui/widgets/section_header.dart';
import 'package:flutter/material.dart';

import '../utils/assets_path.dart';
import '../widgets/hot_deal_grid_card.dart';
import '../widgets/home/home_banner_slider.dart';
import '../widgets/home/horizontal_category_list_view.dart';
import '../widgets/home/horizontal_product_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    double bannerHeight = screenWidth * 0.45;
    if (screenWidth > 600) {
      bannerHeight = 250;
    }

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
              SectionHeader(title: "Category", onTap: () {}),
              const SizedBox(height: 16),
              _buildCategoriesSection(),
              const SizedBox(height: 16),
              SectionHeader(title: "Featured Product", onTap: () {}),
              const SizedBox(height: 16),
              _buildFeaturedProductSection(),
              const SizedBox(height: 16),
              SectionHeader(title: "Best Sellers", onTap: () {}),
              const SizedBox(height: 16),
              _buildFeaturedProductSection(),
              const SizedBox(height: 16),
              SectionHeader(title: "Hot Deals", onTap: () {}),
              const SizedBox(height: 16),
              _buildHotDealsGridViewSection(),
              const SizedBox(height: 16),
              _buildFreeShippingCardSection(screenWidth),
              const SizedBox(height: 16),
              _buildNewArrivalsCardSection(screenWidth),
              const SizedBox(height: 16),
              SectionHeader(title: "Recommended For You", onTap: () {}),
              const SizedBox(height: 16),
              _buildRecommendedForYouSection(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewArrivalsCardSection(double screenWidth) {  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF0B1220), Color(0xFF1D2C40)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New Arrivals",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Explore the latest tech trends & tools for your daily life",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF0B1220),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Explore ",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }

  Widget _buildFreeShippingCardSection(double screenWidth) {return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFFF6A00), Color(0xFFFFA100)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Free Shipping",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "On all gadget orders over \$50",
                    style: TextStyle(color: Colors.white),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: const Text("Claim Now"),
            ),
          ],
        ),
      ),
    ),
  );
  }


  Widget _buildRecommendedForYouSection() {
    final double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;
    if (screenWidth > 900) {
      crossAxisCount = 4;
    } else if (screenWidth > 600) {
      crossAxisCount = 3;
    }
    double childAspectRatio = 0.90;
    if (screenWidth < 380) {
      childAspectRatio = 0.80;
    } else if (screenWidth < 600) {
      childAspectRatio = 0.90;
    }
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        return const RecommendedForYouGridCard();
      },
    );
  }

  Widget _buildHotDealsGridViewSection() {
    final double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;
    if (screenWidth > 900) {
      crossAxisCount = 4;
    } else if (screenWidth > 600) {
      crossAxisCount = 3;
    }
    double childAspectRatio = 0.90;
    if (screenWidth < 380) {
      childAspectRatio = 0.80;
    } else if (screenWidth < 600) {
      childAspectRatio = 0.90;
    }
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,

      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        return const HotDealGridCard();
      },
    );
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
