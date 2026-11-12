import 'package:famous_gadget/view/category/sub_category_screen.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../navigation/app_navigation.dart';

class WebCategory {
  const WebCategory(this.name, this.count, this.image, this.routeName);

  final String name;
  final String count;
  final String image;
  final String routeName;
}

class WebCategoryCard extends StatelessWidget {
  const WebCategoryCard({super.key, required this.category});

  final WebCategory category;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => AppRoutes.to<void>(
          route: AppRoutes.subCategory,
          arguments: {'categoryName': category.routeName},
          mobileBuilder: () =>
              SubCategoryScreen(categoryName: category.routeName),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(category.image, fit: BoxFit.contain),
              ),
              const SizedBox(height: 8),
              Text(
                category.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 2),
              Text(
                '${category.count} items',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
