import 'package:flutter/material.dart';
import '../category/product_list_screen.dart';
import 'app_navigation.dart';

class HeaderSearchBox extends StatelessWidget {
  const HeaderSearchBox({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        onSubmitted: _openProductSearch,
        decoration: InputDecoration(
          hintText: 'Search authentic smart watches, earbuds, gimbals...',
          prefixIcon: const Icon(Icons.search, size: 20),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(4),
            child: FilledButton(
              onPressed: () => _openProductSearch(controller.text),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                minimumSize: Size.zero,
              ),
              child: const Text('Search'),
            ),
          ),
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme.of(context).dividerColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
      ),
    );
  }

  void _openProductSearch(String query) {
    AppRoutes.to<void>(
      route: AppRoutes.search,
      arguments: {'searchQuery': query},
      mobileBuilder: () => ProductListScreen(
        title: 'Search Products',
        initialSearchActive: true,
        initialSearchQuery: query,
      ),
    );
  }
}
