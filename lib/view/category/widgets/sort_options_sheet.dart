import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SortOptionsSheet extends StatelessWidget {
  final bool isAscending;
  final Function(bool) onSortChanged;

  const SortOptionsSheet({
    super.key,
    required this.isAscending,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Popularity'),
            trailing: isAscending
                ? const Icon(Icons.check, color: AppColors.primary)
                : null,
            onTap: () {
              onSortChanged(true);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Price: low to high'),
            trailing: !isAscending
                ? const Icon(Icons.check, color: AppColors.primary)
                : null,
            onTap: () {
              onSortChanged(false);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
