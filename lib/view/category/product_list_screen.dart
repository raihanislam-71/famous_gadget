import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../navigation/app_navigation.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  final String title;
  final bool initialSearchActive;
  final String initialSearchQuery;

  const ProductListScreen({
    super.key,
    required this.title,
    this.initialSearchActive = false,
    this.initialSearchQuery = '',
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final List<String> _filterChips = [
    "All Brands",
    "Price: Low to High",
    "Ratings 4.5+",
    "In Stock",
  ];
  late bool _isSearching;
  late String _searchQuery;

  @override
  void initState() {
    super.initState();
    _isSearching = widget.initialSearchActive;
    _searchQuery = widget.initialSearchQuery;
    _searchController.text = widget.initialSearchQuery;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _startSearch() {
    setState(() => _isSearching = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _searchFocusNode.requestFocus();
    });
  }

  void _stopSearch() {
    _searchController.clear();
    setState(() {
      _isSearching = false;
      _searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktopWeb = kIsWeb && MediaQuery.sizeOf(context).width >= 768;
    final theme = Theme.of(context);
    final products = Product.demoProducts.where((product) {
      return product.name.toLowerCase().contains(
        _searchQuery.trim().toLowerCase(),
      );
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                autofocus: widget.initialSearchActive,
                onChanged: (query) => setState(() => _searchQuery = query),
                textInputAction: TextInputAction.search,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  hintText: 'Search products',
                  hintStyle: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
              )
            : Text(
                widget.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
        automaticallyImplyLeading: !isDesktopWeb,
        leading: isDesktopWeb
            ? null
            : IconButton(
                onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  } else {
                    AppRoutes.backToHome();
                  }
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
        actions: [
          IconButton(
            tooltip: _isSearching ? 'Clear search' : 'Search products',
            onPressed: _isSearching ? _stopSearch : _startSearch,
            icon: Icon(_isSearching ? Icons.close : Icons.search),
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (products.isEmpty) {
                    return Center(
                      child: Text(
                        'No products found',
                        style: theme.textTheme.bodyLarge,
                      ),
                    );
                  }
                  final columns = constraints.maxWidth < 560
                      ? 2
                      : constraints.maxWidth < 900
                      ? 3
                      : 4;
                  final itemWidth =
                      (constraints.maxWidth - 16 * (columns - 1)) / columns;
                  final childAspectRatio = itemWidth < 228
                      ? itemWidth / 240
                      : 0.95;
                  return GridView.builder(
                    padding: const EdgeInsets.only(top: 8),
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        productId: product.id,
                        isInStock: product.isInStock,
                      );
                    },
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
