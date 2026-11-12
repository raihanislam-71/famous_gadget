import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../widgets/product_card.dart';
import '../navigation/app_navigation.dart';
import 'widgets/sort_options_sheet.dart';
import 'widgets/filter_price_sheet.dart';

class ProductByCategoryScreen extends StatefulWidget {
  final String categoryName;

  const ProductByCategoryScreen({super.key, required this.categoryName});

  @override
  State<ProductByCategoryScreen> createState() =>
      _ProductByCategoryScreenState();
}

class _ProductByCategoryScreenState extends State<ProductByCategoryScreen> {
  bool _sortAscending = true;
  RangeValues _priceRange = const RangeValues(0, 100000);
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearching = false;
  String _searchQuery = '';

  List<String> get _visibleProductIds =>
      List.generate(8, (index) => '$index').where((productId) {
        final productName = Product.demoForId(productId).name.toLowerCase();
        return productName.contains(_searchQuery.trim().toLowerCase());
      }).toList();

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
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWeb = kIsWeb;
    final visibleProductIds = _visibleProductIds;
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                onChanged: (query) => setState(() => _searchQuery = query),
                textInputAction: TextInputAction.search,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  hintText: 'Search products',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
              )
            : Text(
                widget.categoryName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 0,
        automaticallyImplyLeading: !isWeb,
        leading: isWeb
            ? null
            : IconButton(
                onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  } else {
                    AppRoutes.backToHome();
                  }
                },
                icon: const Icon(CupertinoIcons.back),
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                OutlinedButton.icon(
                  onPressed: _showSortOptions,
                  icon: const Icon(Icons.sort, size: 16),
                  label: Text(
                    _sortAscending ? 'Sort: Popularity' : 'Sort: Price',
                    overflow: TextOverflow.ellipsis,
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: _showFilters,
                  icon: const Icon(Icons.filter_list, size: 16),
                  label: const Text("Filters (2)"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (visibleProductIds.isEmpty) {
                    return Center(
                      child: Text(
                        'No products found',
                        style: Theme.of(context).textTheme.bodyLarge,
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
                    itemCount: visibleProductIds.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemBuilder: (context, index) {
                      final productId = visibleProductIds[index];
                      return ProductCard(
                        productId: productId,
                        width: double.infinity,
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

  void _showSortOptions() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SortOptionsSheet(
        isAscending: _sortAscending,
        onSortChanged: (value) => setState(() => _sortAscending = value),
      ),
    );
  }

  void _showFilters() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => FilterPriceSheet(
        initialRange: _priceRange,
        onApply: (range) => setState(() => _priceRange = range),
      ),
    );
  }
}
