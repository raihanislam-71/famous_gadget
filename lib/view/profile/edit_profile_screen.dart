import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/profile_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/assets_path.dart';
import '../widgets/app_buttons.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final ProfileController _profileController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _profileController = Get.find<ProfileController>();
    _firstNameController = TextEditingController(
      text: _profileController.firstName,
    );
    _lastNameController = TextEditingController(
      text: _profileController.lastName,
    );
    _emailController = TextEditingController(text: _profileController.email);
    _phoneController = TextEditingController(text: _profileController.phone);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.pageBackground,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          shape: const Border(bottom: BorderSide(color: AppColors.border)),
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          titleSpacing: 16,
          title: Text(
            'Edit Profile',
            style: AppTextStyles.h2.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SafeArea(
          top: false,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                    child: Column(
                      children: [
                        _buildAvatar(),
                        const SizedBox(height: 20),
                        _buildProfileForm(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  child: AppPrimaryButton(
                    label: 'Save Changes',
                    height: 52,
                    onPressed: _saveChanges,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return GetBuilder<ProfileController>(
      builder: (profile) => SizedBox(
        width: 90,
        height: 90,
        child: Stack(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                profile.initials,
                style: AppTextStyles.h1.copyWith(
                  fontSize: 32,
                  color: AppColors.surface,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.navyDark,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  AssetsPath.profileCamera,
                  width: 14,
                  height: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildField(
          label: 'First Name',
          controller: _firstNameController,
          capitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 16),
        _buildField(
          label: 'Last Name',
          controller: _lastNameController,
          capitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 16),
        _buildField(
          label: 'Email Address',
          controller: _emailController,
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
        _buildField(
          label: 'Phone Number',
          controller: _phoneController,
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    TextCapitalization capitalization = TextCapitalization.none,
    String? Function(String?)? validator,
  }) {
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

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    return GetUtils.isEmail(email) ? null : 'Enter a valid email address';
  }

  void _saveChanges() {
    if (!_formKey.currentState!.validate()) return;

    _profileController.updateProfile(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
    );
    Get.back<void>();
  }
}
