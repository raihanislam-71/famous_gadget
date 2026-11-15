part of '../product_details_screen.dart';

extension _ProductDetailsDesktopOutOfStockActions on _ProductDetailsScreenState {
    Widget _buildDesktopOutOfStockActions(BuildContext context) {
      final theme = Theme.of(context);
  
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Out of stock warning banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.dangerRed.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.dangerRed.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.info_outline,
                  color: AppColors.dangerRed,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Item Unavailable',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.dangerRed,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'This gadget is temporarily unavailable. We are restocking soon! Click below to receive an instant stock alert or explore similar in-stock items.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Disabled button & Notify me button
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: null,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    disabledBackgroundColor:
                        theme.colorScheme.surfaceContainerHighest,
                    disabledForegroundColor: theme.colorScheme.onSurfaceVariant,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('Currently Out of Stock'),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: _notifyRestock,
                  icon: const Icon(Icons.notifications_active_outlined, size: 20),
                  label: const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Notify When Available',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.amber,
                    foregroundColor: Colors.black87,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }
  
    // ---------------------------------------------------------------------------
    // DESKTOP FULL-WIDTH BOTTOM SECTIONS
    // ---------------------------------------------------------------------------
}
