import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:famous_gadget/view/utils/app_text_styles.dart';
import 'package:flutter/material.dart';


class PasswordStrengthBar extends StatelessWidget {
  const PasswordStrengthBar({super.key, required this.strength});

  final int strength;

  @override
  Widget build(BuildContext context) {
    final strengthLabel = switch (strength) {
      0 => 'Password strength',
      1 => 'Weak Password',
      2 => 'Good Password',
      _ => 'Strong Password',
    };
    final strengthColor = strength < 2
        ? AppColors.dangerRed
        : AppColors.successGreen;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(
            3,
            (index) => Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(right: index == 2 ? 0 : 4),
                decoration: BoxDecoration(
                  color: index < strength ? strengthColor : AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          strengthLabel,
          style: AppTextStyles.caption.copyWith(
            fontSize: 12,
            color: strengthColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
