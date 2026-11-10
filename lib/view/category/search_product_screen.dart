import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/product_card.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 0,
        title: Container(
          height: 45,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search products...',
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.close),
                onPressed: _searchController.clear,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth < 560
                ? 2
                : constraints.maxWidth < 900
                ? 3
                : 4;
            return GridView.builder(
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: columns == 2
                    ? 0.72
                    : columns == 3
                    ? 0.78
                    : 0.82,
              ),
              itemBuilder: (context, index) {
                return ProductCard(
                  productId: index.toString(),
                  width: double.infinity,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
