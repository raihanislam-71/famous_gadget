import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/bottom_nav_controller.dart';
import '../utils/assets_path.dart';
import '../utils/extensions.dart';
import '../home/widgets/category_card.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<Map<String, String>> categories = [
    {'name': 'Mobile', 'image': AssetsPath.phone},
    {'name': 'Camera', 'image': AssetsPath.camera},
    {'name': 'Gimbal', 'image': AssetsPath.gimbal},
    {'name': 'Projector', 'image': AssetsPath.projector},
    {'name': 'Watch', 'image': AssetsPath.smartWatch},
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
        leading: IconButton(
          onPressed: () {
            Get.find<BottomNavController>().backToHome();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search categories...',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  categoryName: categories[index]['name']!,
                  imagePath: categories[index]['image']!,
                );
              },
            ),
          ),
        ],
      ).padOnly(top: 8),
    );
  }
}
