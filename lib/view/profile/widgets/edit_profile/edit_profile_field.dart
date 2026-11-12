import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:famous_gadget/view/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class EditProfileField extends StatelessWidget {
  const EditProfileField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.capitalization = TextCapitalization.none,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextCapitalization capitalization;
  final String? Function(String?)? validator;

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
        const SizedBox(height: 8),
        SizedBox(
          height: 48,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            textCapitalization: capitalization,
            validator: validator ?? _requiredValidator,
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

  OutlineInputBorder _inputBorder({Color color = AppColors.border}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color),
    );
  }

  String? _requiredValidator(String? value) {
    return value == null || value.trim().isEmpty ? 'Required' : null;
  }
}
