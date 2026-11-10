import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../widgets/product_card.dart';
import 'search_product_screen.dart';
import '../navigation/app_navigation.dart';

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

  @override
  Widget build(BuildContext context) {
    final isDesktopWeb = kIsWeb && MediaQuery.sizeOf(context).width >= 768;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
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
            onPressed: () {
              AppRoutes.to<void>(
                route: AppRoutes.search,
                mobileBuilder: () => const SearchProductScreen(),
              );
            },
            icon: const Icon(Icons.search),
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
                  final columns = constraints.maxWidth < 560
                      ? 2
                      : constraints.maxWidth < 900
                      ? 3
                      : 4;
                  return GridView.builder(
                    itemCount: 8,
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
          ),
        ],
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Popularity'),
              trailing: _sortAscending
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                setState(() => _sortAscending = true);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Price: low to high'),
              trailing: !_sortAscending
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                setState(() => _sortAscending = false);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFilters() {
    var selectedRange = _priceRange;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Filter by price',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                RangeSlider(
                  values: selectedRange,
                  min: 0,
                  max: 100000,
                  divisions: 20,
                  labels: RangeLabels(
                    '৳${selectedRange.start.round()}',
                    '৳${selectedRange.end.round()}',
                  ),
                  onChanged: (range) =>
                      setSheetState(() => selectedRange = range),
                ),
                FilledButton(
                  onPressed: () {
                    setState(() => _priceRange = selectedRange);
                    Navigator.pop(context);
                  },
                  child: const Text('Apply filters'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
