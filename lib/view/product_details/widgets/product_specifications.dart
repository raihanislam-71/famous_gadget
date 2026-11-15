import 'package:flutter/material.dart';
import '../../../models/product.dart';
import '../../utils/app_colors.dart';

class ProductSpecifications extends StatelessWidget {
  const ProductSpecifications({
    super.key,
    required this.product,
    this.isDesktop = false,
  });

  final Product product;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return isDesktop ? _buildDesktop(context) : _buildMobile(context);
  }

  Widget _buildDesktop(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
            child: Row(
              children: [
                const Icon(Icons.tune, color: AppColors.primary, size: 22),
                const SizedBox(width: 10),
                Text(
                  'Key Specifications',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.dividerColor),
          ...product.specifications.entries.toList().asMap().entries.map((
            entry,
          ) {
            final index = entry.key;
            final item = entry.value;
            final isEven = index % 2 == 0;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              color: isEven
                  ? (theme.brightness == Brightness.dark
                      ? const Color(0xFF142032)
                      : const Color(0xFFF8FAFC))
                  : Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      item.key,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      item.value,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMobile(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Key Specifications',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          for (final spec in product.specifications.entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      spec.key,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      spec.value,
                      textAlign: TextAlign.end,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
