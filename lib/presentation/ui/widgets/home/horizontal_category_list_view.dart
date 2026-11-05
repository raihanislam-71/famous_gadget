import 'package:bdcalling_class/presentation/ui/utils/assets_path.dart';
import 'package:flutter/material.dart';

import '../category_card.dart';

class HorizontalCategoriesListView extends StatelessWidget {
  HorizontalCategoriesListView({super.key});

  final List<String> _categoryName = [
    "Smart Watch",
    "Camera",
    "Gimbal",
    "Phone",
    "Projector",
  ];

  final List<String> _categoryImagePath = [
    AssetsPath.smartWatch,
    AssetsPath.camera,
    AssetsPath.gimbal,
    AssetsPath.phone,
    AssetsPath.projector,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _categoryName.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return CategoryCard(
          imagePath: _categoryImagePath[index],
          categoryName: _categoryName[index],
        );
      },
      separatorBuilder: (_, _) => const SizedBox(width: 16),
    );
  }
}
