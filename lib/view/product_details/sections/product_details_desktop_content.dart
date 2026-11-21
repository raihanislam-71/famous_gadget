part of '../product_details_screen.dart';

extension _ProductDetailsDesktopContent on _ProductDetailsScreenState {
    Widget _buildDesktopSpecificationsCard(BuildContext context) {
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
            ..._product.specifications.entries.toList().asMap().entries.map((
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

    Widget _buildDesktopDescriptionCard(BuildContext context) {
      final theme = Theme.of(context);
  
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.description_outlined,
                  color: AppColors.primary,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Text(
                  'Description',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              _product.description,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.7,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Enjoy peace of mind with authentic gadgets sourced directly from official distribution channels. Every purchase includes warranty coverage, professional after-sales support, and verified hardware testing.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
          ],
        ),
      );
    }
}
