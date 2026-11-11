import 'package:flutter/material.dart';

import 'product_details_screen.dart';

class OutOfStockProductDetailsScreen extends StatelessWidget {
  const OutOfStockProductDetailsScreen({super.key, this.productId = 'sony-xm5'});

  final String productId;

  @override
  Widget build(BuildContext context) =>
      ProductDetailsScreen(productId: productId, isInStock: false);
}
