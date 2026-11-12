import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:famous_gadget/view/utils/app_text_styles.dart';
import 'package:flutter/material.dart';


class AddressTextField extends StatelessWidget {
  const AddressTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.keyboardType,
    this.capitalization = TextCapitalization.none,
    this.minLines = 1,
    this.maxLines = 1,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextCapitalization capitalization;
  final int minLines;
  final int maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: AppTextStyles.badge.copyWith(
            fontSize: 11,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textCapitalization: capitalization,
          minLines: minLines,
          maxLines: maxLines,
          validator: validator ?? _requiredValidator,
          style: AppTextStyles.body.copyWith(
            fontSize: 12,
            height: 1.2,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.caption.copyWith(fontSize: 11),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: _inputBorder(),
            enabledBorder: _inputBorder(),
            focusedBorder: _inputBorder(color: AppColors.primary),
            errorBorder: _inputBorder(color: AppColors.dangerRed),
            focusedErrorBorder: _inputBorder(color: AppColors.dangerRed),
            errorStyle: const TextStyle(fontSize: 10, height: 1),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _inputBorder({Color color = AppColors.border}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'This field is required';
    return null;
  }
}
