import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:famous_gadget/view/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../../../../models/saved_address.dart';


class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.address,
    required this.onEdit,
  });

  final SavedAddress address;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  '${address.name} (${address.type})',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.badge.copyWith(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              if (address.isDefault) ...[
                const SizedBox(width: 6),
                _buildDefaultBadge(),
              ],
              const Spacer(),
              IconButton(
                onPressed: onEdit,
                tooltip: 'Edit address',
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints.tightFor(width: 32, height: 32),
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 14,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            address.phone,
            style: AppTextStyles.caption.copyWith(fontSize: 11),
          ),
          const SizedBox(height: 2),
          Text(
            address.formattedAddress,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption.copyWith(fontSize: 11, height: 1.25),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.softPeach,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        'DEFAULT',
        style: AppTextStyles.badge.copyWith(
          fontSize: 7,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
