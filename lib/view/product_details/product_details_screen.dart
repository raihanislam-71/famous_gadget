import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/review_controller.dart';
import '../../models/product.dart';
import 'widgets/product_breadcrumbs.dart';
import 'widgets/product_customer_reviews_section.dart';
import 'widgets/product_description_card.dart';
import 'widgets/product_related_section.dart';
import 'widgets/product_specifications.dart';
import 'widgets/product_trust_badges_card.dart';
import 'widgets/product_info_section.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;
  final bool isInStock;

  const ProductDetailsScreen({super.key, this.productId = 'anker-r50i', this.isInStock = true});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late Product _product;
  final ReviewController _reviewController = Get.put(ReviewController());

  @override
  void initState() {
    super.initState();
    _product = Product.demoForId(widget.productId, isInStock: widget.isInStock);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 900;
          return isDesktop ? _buildDesktopView() : _buildMobileView();
        },
      ),
    );
  }

  Widget _buildDesktopView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          ProductBreadcrumbs(productName: _product.name, onHomeTap: () {}, onProductsTap: () {}),
          Row(
            children: [
              // Gallery & Badges
              const Expanded(flex: 5, child: Column(children: [Placeholder(), ProductTrustBadgesCard()])),
              // Info & Actions
              Expanded(flex: 6, child: ProductInfoSection(product: _product, isInStock: widget.isInStock, onBuyNow: () {}, onNotify: () {})),
            ],
          ),
          ProductSpecifications(product: _product, isDesktop: true),
          ProductDescriptionCard(description: _product.description),
          ProductCustomerReviewsSection(product: _product, reviewController: _reviewController),
          ProductRelatedSection(product: _product),
        ],
      ),
    );
  }

  Widget _buildMobileView() {
    return ListView(
      children: [
        const Placeholder(fallbackHeight: 280), // Image Slider
        ProductInfoSection(product: _product, isInStock: widget.isInStock, onBuyNow: () {}, onNotify: () {}),
        ProductSpecifications(product: _product, isDesktop: false),
        ProductDescriptionCard(description: _product.description),
        ProductCustomerReviewsSection(product: _product, reviewController: _reviewController),
        ProductRelatedSection(product: _product),
      ],
    );
  }
}
