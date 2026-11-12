import 'package:famous_gadget/view/product_details/widgets/product_breadcrumbs.dart';
import 'package:famous_gadget/view/product_details/widgets/product_customer_reviews_section.dart';
import 'package:famous_gadget/view/product_details/widgets/product_description_card.dart';
import 'package:famous_gadget/view/product_details/widgets/product_info_section.dart';
import 'package:famous_gadget/view/product_details/widgets/product_related_section.dart';
import 'package:famous_gadget/view/product_details/widgets/product_specifications.dart';
import 'package:famous_gadget/view/product_details/widgets/product_trust_badges_card.dart';
import 'package:flutter/material.dart';

import '../../../../models/product.dart';

class DesktopProductDetailsView extends StatelessWidget {
  final Product product;
  final bool isInStock;
  final dynamic reviewController;

  const DesktopProductDetailsView({
    super.key,
    required this.product,
    required this.isInStock,
    required this.reviewController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          ProductBreadcrumbs(
            productName: product.name,
            onHomeTap: () {},
            onProductsTap: () {},
          ),
          Row(
            children: [
              const Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Placeholder(fallbackHeight: 400),
                    ProductTrustBadgesCard(),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: ProductInfoSection(
                  product: product,
                  isInStock: isInStock,
                  onBuyNow: () {},
                  onNotify: () {},
                ),
              ),
            ],
          ),
          ProductSpecifications(product: product, isDesktop: true),
          ProductDescriptionCard(description: product.description),
          ProductCustomerReviewsSection(
            product: product,
            reviewController: reviewController,
          ),
          ProductRelatedSection(product: product),
        ],
      ),
    );
  }
}
