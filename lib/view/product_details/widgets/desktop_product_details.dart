import 'package:flutter/material.dart';
import '../../../models/product.dart';
import '../widgets/product_breadcrumbs.dart';
import '../widgets/product_customer_reviews_section.dart';
import '../widgets/product_description_card.dart';
import '../widgets/product_related_section.dart';
import '../widgets/product_specifications.dart';
import '../widgets/product_trust_badges_card.dart';
import 'product_info_section.dart';

class DesktopProductDetails extends StatelessWidget {
  const DesktopProductDetails({
    super.key,
    required this.product,
    required this.reviewController,
    required this.onNotify,
  });

  final Product product;
  final dynamic reviewController;
  final VoidCallback onNotify;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductBreadcrumbs(productName: product.name, onHomeTap: () {}, onProductsTap: () {}),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: Column(children: [const Placeholder(fallbackHeight: 400), const SizedBox(height: 24), const ProductTrustBadgesCard()])),
                  const SizedBox(width: 36),
                  Expanded(flex: 6, child: ProductInfoSection(product: product, isInStock: product.isInStock, onBuyNow: () {}, onNotify: onNotify)),
                ],
              ),
              const SizedBox(height: 48),
              ProductSpecifications(product: product, isDesktop: true),
              const SizedBox(height: 32),
              ProductDescriptionCard(description: product.description),
              const SizedBox(height: 32),
              ProductCustomerReviewsSection(product: product, reviewController: reviewController),
              const SizedBox(height: 40),
              ProductRelatedSection(product: product),
            ],
          ),
        ),
      ),
    );
  }
}
