import 'package:famous_gadget/view/category/category_screen.dart';
import 'package:famous_gadget/view/category/product_by_category_screen.dart';
import 'package:famous_gadget/view/navigation/app_navigation.dart';
import 'package:famous_gadget/view/navigation/web_site_header.dart';
import 'package:flutter/material.dart';
import 'widgets/web/web_footer.dart';
import 'widgets/web/web_hero_section.dart';
import 'widgets/web/web_home_data.dart';
import 'widgets/web/web_home_sections.dart';
import 'widgets/web/web_hot_deals_section.dart';
import 'widgets/web/web_newsletter_signup.dart';
import 'widgets/web/web_promo_banners_section.dart';
import 'widgets/web/web_section_layout.dart';
import 'widgets/web/web_trust_section.dart';

class WebHomeScreen extends StatelessWidget {
  const WebHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const WebSiteHeader(),
            WebHeroSection(onShopNow: _openCategories, onViewDeals: _openProducts),
            WebCategorySection(categories: WebHomeData.categories, onSeeAll: _openCategories),
            WebProductsSection(
              title: 'Featured Products',
              subtitle: 'Highly-rated authentic tech gear selected for you',
              products: WebHomeData.featured,
              onSeeAll: () => _openProducts('Featured Products'),
            ),
            WebProductsSection(
              title: 'Best Sellers',
              subtitle: 'Our overall top-selling electronic essentials',
              products: WebHomeData.bestSellers,
              onSeeAll: () => _openProducts('Best Sellers'),
              shaded: true,
            ),
            WebHotDealsSection(onViewProducts: _openProducts),
            const WebWebContent(child: WebPromoBannersSection()),
            WebProductsSection(
              title: 'New Arrivals',
              subtitle: 'The latest smart gadgets hitting our shelves this week',
              products: WebHomeData.newArrivals,
              onSeeAll: () => _openProducts('New Arrivals'),
            ),
            WebProductsSection(
              title: 'Recommended For You',
              subtitle: 'Tailored gadgets matching your interests',
              products: WebHomeData.recommended,
              onSeeAll: () => _openProducts('Recommended For You'),
              shaded: true,
            ),
            const WebSectionBand(shaded: true, child: WebWebContent(child: WebTrustSection())),
            const WebWebContent(child: WebNewsletterSignup()),
            WebFooter(onAccountLinkTap: _openAccount),
          ],
        ),
      ),
    );
  }

  void _openCategories() => AppRoutes.to<void>(route: AppRoutes.categories, mobileBuilder: () => const CategoryScreen());

  void _openProducts(String categoryName) => AppRoutes.to<void>(
        route: AppRoutes.products,
        arguments: {'categoryName': categoryName},
        mobileBuilder: () => ProductByCategoryScreen(categoryName: categoryName),
      );

  void _openAccount(String label) => AppRoutes.to<void>(
        route: label == 'Order History' ? AppRoutes.orders : AppRoutes.account,
        arguments: {'isPreview': true},
        mobileBuilder: () => const SizedBox.shrink(),
      );
}
