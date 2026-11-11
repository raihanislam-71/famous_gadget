import 'package:bdcalling_class/view/category/product_by_category_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../navigation/app_navigation.dart';
import '../utils/app_colors.dart';

class SubCategoryScreen extends StatefulWidget {
  final String categoryName;

  const SubCategoryScreen({super.key, required this.categoryName});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearching = false;

  final List<Map<String, dynamic>> _subCategories = [
    {'name': 'Flagship Phones', 'items': 28, 'icon': Icons.phone_android},
    {'name': 'Mid-Range Smartphones', 'items': 45, 'icon': Icons.phone_iphone},
    {'name': 'Budget Phones', 'items': 32, 'icon': Icons.smartphone},
    {'name': 'Tablets & iPads', 'items': 22, 'icon': Icons.tablet_mac},
    {'name': 'Phone Cases & Covers', 'items': 15, 'icon': Icons.cases_outlined},
    {
      'name': 'Screen Protectors',
      'items': 18,
      'icon': Icons.monitor_weight_outlined,
    },
    {'name': 'Chargers & Cables', 'items': 41, 'icon': Icons.bolt},
  ];

  List<Map<String, dynamic>> _filteredSubCategories = [];

  @override
  void initState() {
    super.initState();
    _filteredSubCategories = List<Map<String, dynamic>>.from(_subCategories);
  }

  void _filterSubCategories(String query) {
    setState(() {
      final trimmedQuery = query.trim().toLowerCase();
      if (trimmedQuery.isEmpty) {
        _filteredSubCategories = List<Map<String, dynamic>>.from(
          _subCategories,
        );
      } else {
        _filteredSubCategories = _subCategories
            .where(
              (item) =>
                  (item['name'] as String).toLowerCase().contains(trimmedQuery),
            )
            .toList();
      }
    });
  }

  void _startSearch() {
    setState(() => _isSearching = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _searchFocusNode.requestFocus();
    });
  }

  void _stopSearch() {
    _searchController.clear();
    _filterSubCategories('');
    setState(() => _isSearching = false);
  }

  @override
  Widget build(BuildContext context) {
    final isWeb = kIsWeb;

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                textInputAction: TextInputAction.search,
                onChanged: _filterSubCategories,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  hintText: 'Search sub-categories',
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
            tooltip: 'Search sub-categories',
            onPressed: _isSearching ? _stopSearch : _startSearch,
            icon: Icon(_isSearching ? Icons.close : Icons.search),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _filteredSubCategories.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final item = _filteredSubCategories[index];
          return ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.themeColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(item['icon'], color: AppColors.themeColor),
            ),
            title: Text(
              item['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${item['items']} items'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              final categoryName = item['name'] as String;
              AppRoutes.to<void>(
                route: AppRoutes.products,
                arguments: {'categoryName': categoryName},
                mobileBuilder: () =>
                    ProductByCategoryScreen(categoryName: categoryName),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }
}
