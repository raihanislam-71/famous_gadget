import 'package:famous_gadget/view/product_details/widgets/product_customer_reviews_section.dart';
import 'package:famous_gadget/view/product_details/widgets/product_description_card.dart';
import 'package:famous_gadget/view/product_details/widgets/product_info_section.dart';
import 'package:famous_gadget/view/product_details/widgets/product_related_section.dart';
import 'package:famous_gadget/view/product_details/widgets/product_specifications.dart';
import 'package:flutter/material.dart';
import '../../../../models/product.dart';

class MobileProductDetailsView extends StatelessWidget {
  final Product product;
  final bool isInStock;
  final dynamic reviewController;

  const MobileProductDetailsView({
    super.key,
    required this.product,
    required this.isInStock,
    required this.reviewController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Placeholder(fallbackHeight: 280), // Image Slider
        ProductInfoSection(product: product, isInStock: isInStock, onBuyNow: () {}, onNotify: () {}),
        ProductSpecifications(product: product, isDesktop: false),
        ProductDescriptionCard(description: product.description),
        ProductCustomerReviewsSection(product: product, reviewController: reviewController),
        ProductRelatedSection(product: product),
      ],
    );
  }
}
