import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/review_controller.dart';
import '../../models/product.dart';
import 'layouts/desktop/desktop_product_details_view.dart';
import 'layouts/mobile/mobile_product_details_view.dart';

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
          return isDesktop
              ? DesktopProductDetailsView(product: _product, isInStock: widget.isInStock, reviewController: _reviewController)
              : MobileProductDetailsView(product: _product, isInStock: widget.isInStock, reviewController: _reviewController);
        },
      ),
    );
  }
}
