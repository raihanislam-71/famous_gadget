import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/profile_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/app_buttons.dart';
import 'widgets/edit_profile/edit_profile_avatar.dart';
import 'widgets/edit_profile/edit_profile_form.dart';

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
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.pageBackground,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: _buildAppBar(context),
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
                        const EditProfileAvatar(),
                        const SizedBox(height: 20),
                        EditProfileFormWidget(
                          firstNameController: _firstNameController,
                          lastNameController: _lastNameController,
                          emailController: _emailController,
                          phoneController: _phoneController,
                        ),
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

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
        'Edit Profile Screen',
        style: AppTextStyles.h2.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
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

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
