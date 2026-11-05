import 'package:flutter/material.dart';
import '../product_card.dart';

class HorizontalProductListView extends StatelessWidget {
  const HorizontalProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return ProductCard(productId: index.toString(),);
      },
      separatorBuilder: (_, _) => const SizedBox(width: 8),
    );
  }
}