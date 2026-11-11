import 'package:famous_gadget/view/utils/assets_path.dart';
import 'package:flutter/material.dart';

import '../../category/sub_category_screen.dart';
import '../../navigation/app_navigation.dart';
import 'category_card.dart';

class HorizontalCategoriesListView extends StatelessWidget {
  HorizontalCategoriesListView({super.key});

  final List<String> _categoryName = [
    "Smart Watch",
    "Camera",
    "Gimbal",
    "Smartphones & Tablets",
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
      padding: const EdgeInsets.symmetric(horizontal: 4),
      itemCount: _categoryName.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return CategoryCard(
          imagePath: _categoryImagePath[index],
          categoryName: _categoryName[index],
          onTap: () {
            AppRoutes.to<void>(
              route: AppRoutes.subCategory,
              arguments: {'categoryName': _categoryName[index]},
              mobileBuilder: () =>
                  SubCategoryScreen(categoryName: _categoryName[index]),
            );
          },
        );
      },
      separatorBuilder: (_, _) => const SizedBox(width: 10),
    );
  }
}
