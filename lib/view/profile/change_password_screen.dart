import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/assets_path.dart';
import '../widgets/app_buttons.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _hasMinimumLength => _newPasswordController.text.length >= 8;
  bool get _hasMixedCase =>
      RegExp(r'[A-Z]').hasMatch(_newPasswordController.text) &&
      RegExp(r'[a-z]').hasMatch(_newPasswordController.text);
  bool get _hasNumber => RegExp(r'\d').hasMatch(_newPasswordController.text);
  bool get _hasSpecial =>
      RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=/\\[\];`~]')
          .hasMatch(_newPasswordController.text);

  int get _strength {
    if (_newPasswordController.text.isEmpty) return 0;
    return [
      _hasMinimumLength,
      _hasMixedCase,
      _hasNumber || _hasSpecial,
    ].where((isMet) => isMet).length;
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
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.navyDark,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: AppColors.surface,
          shape: const Border(bottom: BorderSide(color: AppColors.border)),
          toolbarHeight: 60,
          titleSpacing: 12,
          leadingWidth: 56,
          leading: IconButton(
            tooltip: 'Back',
            onPressed: Get.back<void>,
            icon: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: AppColors.pageBackground,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(AssetsPath.accountBackArrow),
            ),
          ),
          title: Text(
            'Change Password',
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
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildPasswordField(
                          label: 'Current Password',
                          controller: _currentPasswordController,
                          isVisible: _showCurrentPassword,
                          onToggle: () => setState(
                            () => _showCurrentPassword = !_showCurrentPassword,
                          ),
                          validator: _requiredValidator,
                        ),
                        const SizedBox(height: 20),
                        _buildPasswordField(
                          label: 'New Password',
                          controller: _newPasswordController,
                          isVisible: _showNewPassword,
                          onToggle: () => setState(
                            () => _showNewPassword = !_showNewPassword,
                          ),
                          onChanged: (_) => setState(() {}),
                          validator: _newPasswordValidator,
                        ),
                        const SizedBox(height: 8),
                        _buildStrength(),
                        const SizedBox(height: 20),
                        _buildPasswordField(
                          label: 'Confirm New Password',
                          controller: _confirmPasswordController,
                          isVisible: _showConfirmPassword,
                          onToggle: () => setState(
                            () => _showConfirmPassword = !_showConfirmPassword,
                          ),
                          validator: _confirmPasswordValidator,
                        ),
                        const SizedBox(height: 20),
                        _buildRequirements(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  child: AppPrimaryButton(
                    label: 'Update Password',
                    height: 52,
                    onPressed: _updatePassword,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: AppTextStyles.badge.copyWith(
            fontSize: 13,
            color: AppColors.navyDark,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 48,
          child: TextFormField(
            controller: controller,
            obscureText: !isVisible,
            validator: validator,
            onChanged: onChanged,
            style: AppTextStyles.body.copyWith(fontSize: 14, height: 1),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              suffixIconConstraints: const BoxConstraints(minWidth: 52),
              suffixIcon: TextButton(
                onPressed: onToggle,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  textStyle: AppTextStyles.badge.copyWith(fontSize: 12),
                ),
                child: Text(isVisible ? 'Hide' : 'Show'),
              ),
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

  Widget _buildStrength() {
    final strengthLabel = switch (_strength) {
      0 => 'Password strength',
      1 => 'Weak Password',
      2 => 'Good Password',
      _ => 'Strong Password',
    };
    final strengthColor = _strength < 2
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
                  color: index < _strength ? strengthColor : AppColors.border,
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

  Widget _buildRequirements() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password Requirements',
            style: AppTextStyles.badge.copyWith(
              fontSize: 13,
              color: AppColors.navyDark,
            ),
          ),
          const SizedBox(height: 8),
          _RequirementRow(
            label: 'At least 8 characters long',
            isMet: _hasMinimumLength,
          ),
          const SizedBox(height: 8),
          _RequirementRow(
            label: 'Includes uppercase & lowercase letters',
            isMet: _hasMixedCase,
          ),
          const SizedBox(height: 8),
          _RequirementRow(
            label: 'Includes at least one number',
            isMet: _hasNumber,
          ),
          const SizedBox(height: 8),
          _RequirementRow(
            label: 'Includes a special character (e.g. ! @ #)',
            isMet: _hasSpecial,
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _inputBorder({Color color = AppColors.border}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color),
    );
  }

  String? _requiredValidator(String? value) {
    return value == null || value.isEmpty ? 'Required' : null;
  }

  String? _newPasswordValidator(String? value) {
    if (value == null || value.length < 8) {
      return 'Use at least 8 characters';
    }
    if (!_hasMixedCase) return 'Use uppercase and lowercase letters';
    if (!_hasNumber) return 'Include at least one number';
    if (!_hasSpecial) return 'Include at least one special character';
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (value != _newPasswordController.text) return 'Passwords do not match';
    return null;
  }

  void _updatePassword() {
    if (!_formKey.currentState!.validate()) return;

    Get.showSnackbar(
      const GetSnackBar(
        message: 'Password updated in demo mode. No backend is connected.',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      ),
    );
  }
}

class _RequirementRow extends StatelessWidget {
  const _RequirementRow({required this.label, required this.isMet});

  final String label;
  final bool isMet;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          isMet ? AssetsPath.verifiedCheck : AssetsPath.passwordInvalid,
          width: 12,
          height: 12,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.caption.copyWith(
              fontSize: 12,
              color: AppColors.secondaryText,
            ),
          ),
        ),
      ],
    );
  }
}
