import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../controllers/bottom_nav_controller.dart';
import '../utils/assets_path.dart';
import '../home/widgets/category_grid_card.dart';
import 'sub_category_screen.dart';
import '../navigation/app_navigation.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearching = false;
  String _searchQuery = '';

  final List<Map<String, dynamic>> categories = [
    {'name': 'Smartphones', 'image': AssetsPath.phone, 'items': 86},
    {'name': 'Security', 'image': AssetsPath.camera, 'items': 45},
    {'name': 'Gimbal', 'image': AssetsPath.gimbal, 'items': 32},
    {'name': 'Accessories', 'image': AssetsPath.projector, 'items': 210},
    {'name': 'Projector', 'image': AssetsPath.projector, 'items': 28},
    {'name': 'Microphone', 'image': AssetsPath.gimbal, 'items': 54},
    {'name': 'Router', 'image': AssetsPath.projector, 'items': 38},
    {'name': 'Tablet', 'image': AssetsPath.phone, 'items': 67},
    {'name': 'Android TV BOX', 'image': AssetsPath.projector, 'items': 22},
    {'name': 'Router UPS', 'image': AssetsPath.projector, 'items': 19},
  ];

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
    final filteredCategories = categories.where((category) {
      return (category['name'] as String).toLowerCase().contains(
        _searchQuery.trim().toLowerCase(),
      );
    }).toList();

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
                  hintText: 'Search categories',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
              )
            : Text(
                'Categories',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: _isSearching ? 'Clear search' : 'Search categories',
            onPressed: _isSearching ? _stopSearch : _startSearch,
            icon: Icon(_isSearching ? Icons.close : Icons.search),
          ),
        ],
        automaticallyImplyLeading: !isWeb,
        leading: isWeb
            ? null
            : IconButton(
                onPressed: () {
                  Get.find<BottomNavController>().backToHome();
                },
                icon: const Icon(CupertinoIcons.back),
              ),
      ),
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final crossAxisCount = width < 360
                    ? 2
                    : width < 600
                    ? 3
                    : width < 900
                    ? 4
                    : 6;

                if (filteredCategories.isEmpty) {
                  return const Center(child: Text('No categories found'));
                }

                return GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.82,
                  ),
                  itemCount: filteredCategories.length,
                  itemBuilder: (context, index) {
                    final category = filteredCategories[index];
                    return CategoryGridCard(
                      categoryName: category['name']!,
                      imagePath: category['image']!,
                      itemsCount: category['items']!,
                      onTap: () {
                        final categoryName = category['name']! as String;
                        AppRoutes.to<void>(
                          route: AppRoutes.subCategory,
                          arguments: {'categoryName': categoryName},
                          mobileBuilder: () =>
                              SubCategoryScreen(categoryName: categoryName),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
