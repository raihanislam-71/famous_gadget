import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  final String title;

  const ProductListScreen({super.key, required this.title});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final List<String> _filterChips = [
    "All Brands",
    "Price: Low to High",
    "Ratings 4.5+",
    "In Stock"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _filterChips.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return FilterChip(
                  label: Text(_filterChips[index]),
                  onSelected: (bool selected) {},
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                padding: const EdgeInsets.only(top: 8),
                itemCount: 8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  // Standard item index % 2 check to demonstrate both In-Stock and Out-Of-Stock states
                  final bool isInStock = index % 2 == 0;
                  return ProductCard(
                    productId: index.toString(),
                    isInStock: isInStock,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
