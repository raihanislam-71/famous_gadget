import 'package:flutter/material.dart';
import 'web_category_card.dart';
import 'web_product_card.dart';
import 'web_section_layout.dart';
import 'web_section_heading.dart';

class WebCategorySection extends StatelessWidget {
  final List<WebCategory> categories;
  final VoidCallback onSeeAll;

  const WebCategorySection({
    super.key,
    required this.categories,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return WebSectionBand(
      child: WebWebContent(
        child: Column(
          children: [
            WebSectionHeading(
              title: 'Shop by Category',
              subtitle: 'Explore our handpicked collections of trending tech gadgets',
              onSeeAll: onSeeAll,
            ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth < 560 ? 2 : constraints.maxWidth < 900 ? 4 : 8;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 146,
                  ),
                  itemBuilder: (context, index) => WebCategoryCard(category: categories[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class WebProductsSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<WebProduct> products;
  final VoidCallback onSeeAll;
  final bool shaded;

  const WebProductsSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.products,
    required this.onSeeAll,
    this.shaded = false,
  });

  @override
  Widget build(BuildContext context) {
    return WebSectionBand(
      shaded: shaded,
      child: WebWebContent(
        child: Column(
          children: [
            WebSectionHeading(
              title: title,
              subtitle: subtitle,
              onSeeAll: onSeeAll,
            ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth < 560 ? 2 : constraints.maxWidth < 900 ? 3 : 4;
                final itemWidth = (constraints.maxWidth - 16 * (columns - 1)) / columns;
                final aspectRatio = itemWidth < 265 ? itemWidth / 270 : 0.98;
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
                  itemBuilder: (context, index) => WebProductCard(product: products[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
