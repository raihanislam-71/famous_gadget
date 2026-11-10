import 'package:bdcalling_class/view/category/product_by_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../navigation/app_navigation.dart';
import 'search_product_screen.dart';

class SubCategoryScreen extends StatefulWidget {
  final String categoryName;

  const SubCategoryScreen({super.key, required this.categoryName});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final List<Map<String, dynamic>> subCategories = [
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

  @override
  Widget build(BuildContext context) {
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
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        actions: [
          IconButton(
            tooltip: 'Search',
            onPressed: () => AppRoutes.to<void>(
              route: AppRoutes.search,
              mobileBuilder: () => const SearchProductScreen(),
            ),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: subCategories.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.themeColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                subCategories[index]['icon'],
                color: AppColors.themeColor,
              ),
            ),
            title: Text(
              subCategories[index]['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${subCategories[index]['items']} items'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              final categoryName = subCategories[index]['name'] as String;
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
}
