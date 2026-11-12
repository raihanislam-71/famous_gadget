import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:famous_gadget/view/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'edit_profile_field.dart';

class EditProfileFormWidget extends StatelessWidget {
  const EditProfileFormWidget({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EditProfileField(
          label: 'First Name',
          controller: firstNameController,
          capitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 16),
        EditProfileField(
          label: 'Last Name',
          controller: lastNameController,
          capitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 16),
        EditProfileField(
          label: 'Email Address',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: _validateEmail,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 4, top: 4),
          child: Row(
            children: [
              Icon(Icons.check, color: AppColors.successGreen, size: 14),
              SizedBox(width: 4),
              Text(
                'Verified Account',
                style: TextStyle(
                  fontFamily: AppTextStyles.bodyFontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.successGreen,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        EditProfileField(
          label: 'Phone Number',
          controller: phoneController,
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    return GetUtils.isEmail(email) ? null : 'Enter a valid email address';
  }
}
