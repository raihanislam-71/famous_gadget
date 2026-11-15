import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class HeaderIconButton extends StatelessWidget {
  const HeaderIconButton({
    super.key,
    required this.tooltip,
    required this.icon,
    required this.onPressed,
    this.badge = 0,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;
  final int badge;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      constraints: const BoxConstraints.tightFor(width: 40, height: 40),
      padding: EdgeInsets.zero,
      icon: Badge(
        isLabelVisible: badge > 0,
        backgroundColor: AppColors.dangerRed,
        textColor: AppColors.pageBackground,
        label: Text(
          '$badge',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        child: Icon(icon),
      ),
    );
  }
}
