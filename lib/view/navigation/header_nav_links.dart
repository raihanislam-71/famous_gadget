import 'package:flutter/material.dart';
import 'app_navigation.dart';

class HeaderNavLinks extends StatelessWidget {
  const HeaderNavLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 4,
      alignment: WrapAlignment.center,
      children: [
        HeaderLinkItem(
          label: 'New Arrivals',
          onTap: () => _openProducts('New Arrivals'),
        ),
        HeaderLinkItem(label: 'Categories', onTap: _openCategories),
        HeaderLinkItem(
          label: 'Campaigns',
          onTap: () => _openProducts('Hot Deals'),
        ),
      ],
    );
  }

  void _openCategories() {
    AppRoutes.to<void>(
      route: AppRoutes.categories,
      mobileBuilder: () => const SizedBox.shrink(),
    );
  }

  void _openProducts(String categoryName) {
    AppRoutes.to<void>(
      route: AppRoutes.products,
      arguments: {'categoryName': categoryName},
      mobileBuilder: () => const SizedBox.shrink(),
    );
  }
}

class HeaderLinkItem extends StatelessWidget {
  const HeaderLinkItem({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}
