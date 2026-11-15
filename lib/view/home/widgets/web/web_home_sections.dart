import 'package:flutter/material.dart';

import '../../../../models/product.dart';
import '../../../widgets/product_card.dart';
import 'web_category_card.dart';
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
              subtitle:
                  'Explore our handpicked collections of trending tech gadgets',
              onSeeAll: onSeeAll,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 142,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, _) => const SizedBox(width: 4),
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 132,
                    child: WebCategoryCard(category: categories[index]),
                  );
                },
              ),
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
  final List<Product> products;
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
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 260,
                mainAxisExtent: 250,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) =>
                  ProductCard(product: products[index]),
            ),
          ],
        ),
      ),
    );
  }
}
