import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:famous_gadget/view/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmitted;

  const PhoneField({
    super.key,
    required this.controller,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        style: AppTextStyles.uiSemibold.copyWith(fontSize: 15),
        validator: (value) {
          final phone = value?.trim() ?? '';
          if (phone.length != 10 || !phone.startsWith('1')) {
            return 'Enter a valid phone number.';
          }
          return null;
        },
        onFieldSubmitted: (_) => onSubmitted(),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 14, right: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '+880',
                  style: AppTextStyles.uiSemibold.copyWith(fontSize: 15),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 1,
                  height: 18,
                  color: Theme.of(context).dividerColor,
                ),
              ],
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 48,
          ),
          hintText: '1XXXXXXXXX',
          hintStyle: AppTextStyles.body.copyWith(
            color: AppColors.secondaryText,
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          errorStyle: const TextStyle(height: 0, fontSize: 0),
        ),
      ),
    );
  }
}
