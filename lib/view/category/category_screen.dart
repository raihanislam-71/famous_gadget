import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/bottom_nav_controller.dart';
import '../utils/assets_path.dart';
import '../home/widgets/category_grid_card.dart';
import 'sub_category_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.circle_outlined, color: Colors.black),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Get.find<BottomNavController>().backToHome();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
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
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryGridCard(
                      categoryName: categories[index]['name']!,
                      imagePath: categories[index]['image']!,
                      itemsCount: categories[index]['items']!,
                      onTap: () {
                        Get.to(
                          () => SubCategoryScreen(
                            categoryName: categories[index]['name']!,
                          ),
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
