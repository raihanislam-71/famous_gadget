import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class AppQuantityStepper extends StatelessWidget {
  const AppQuantityStepper({
    super.key,
    required this.value,
    required this.onChanged,
    this.minimum = 1,
  }) : assert(minimum >= 0);

  final int value;
  final int minimum;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.pageBackground,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QuantityAction(
            label: '-',
            semanticsLabel: 'Decrease quantity',
            onPressed: value > minimum ? () => onChanged(value - 1) : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '$value',
              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          _QuantityAction(
            label: '+',
            semanticsLabel: 'Increase quantity',
            onPressed: () => onChanged(value + 1),
          ),
        ],
      ),
    );
  }
}

class _QuantityAction extends StatelessWidget {
  const _QuantityAction({
    required this.label,
    required this.semanticsLabel,
    required this.onPressed,
  });

  final String label;
  final String semanticsLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticsLabel,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            label,
            style: AppTextStyles.uiSemibold.copyWith(
              fontSize: 18,
              color: onPressed == null
                  ? AppColors.disabledForeground
                  : AppColors.navyDark,
            ),
          ),
        ),
      ),
    );
  }
}
