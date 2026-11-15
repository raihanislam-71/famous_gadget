import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';


class AddressTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;

  const AddressTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: AppTextStyles.badge.copyWith(
            fontSize: 13,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 44,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            validator: validator,
            style: AppTextStyles.body.copyWith(
              fontSize: 14,
              height: 1,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: _inputBorder(),
              enabledBorder: _inputBorder(),
              focusedBorder: _inputBorder(color: AppColors.primary),
              errorBorder: _inputBorder(color: AppColors.dangerRed),
              focusedErrorBorder: _inputBorder(color: AppColors.dangerRed),
              errorStyle: const TextStyle(fontSize: 10, height: 1),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _inputBorder({Color color = AppColors.border}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color),
      );
}
