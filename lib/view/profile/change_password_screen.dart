import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/app_buttons.dart';
import 'widgets/change_password/password_input_field.dart';
import 'widgets/change_password/password_requirement_row.dart';
import 'widgets/change_password/password_strength_bar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  bool get _hasMinLength => _newController.text.length >= 8;
  bool get _hasMixedCase => RegExp(r'[A-Z]').hasMatch(_newController.text) && RegExp(r'[a-z]').hasMatch(_newController.text);
  bool get _hasNumber => RegExp(r'\d').hasMatch(_newController.text);
  bool get _hasSpecial => RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=/\\[\];`~]').hasMatch(_newController.text);

  int get _strength {
    if (_newController.text.isEmpty) return 0;
    return [_hasMinLength, _hasMixedCase, _hasNumber || _hasSpecial].where((m) => m).length;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: AppColors.pageBackground, statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: _buildAppBar(context),
        body: SafeArea(
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
                        PasswordInputField(label: 'Current Password', controller: _currentController, isVisible: _showCurrent, onToggle: () => setState(() => _showCurrent = !_showCurrent), validator: (v) => v!.isEmpty ? 'Required' : null),
                        const SizedBox(height: 20),
                        PasswordInputField(label: 'New Password', controller: _newController, isVisible: _showNew, onToggle: () => setState(() => _showNew = !_showNew), onChanged: (_) => setState(() {}), validator: _newValidator),
                        const SizedBox(height: 8),
                        PasswordStrengthBar(strength: _strength),
                        const SizedBox(height: 20),
                        PasswordInputField(label: 'Confirm New Password', controller: _confirmController, isVisible: _showConfirm, onToggle: () => setState(() => _showConfirm = !_showConfirm), validator: _confirmValidator),
                        const SizedBox(height: 20),
                        _buildRequirements(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  child: AppPrimaryButton(label: 'Update Password', height: 52, onPressed: _update),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) => AppBar(
        title: Text('Change Password', style: AppTextStyles.h2.copyWith(fontSize: 18, fontWeight: FontWeight.w700)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 0,
        shape: const Border(bottom: BorderSide(color: AppColors.border)),
        toolbarHeight: 60,
      );

  Widget _buildRequirements() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, border: Border.all(color: Theme.of(context).dividerColor), borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Password Requirements', style: AppTextStyles.badge.copyWith(fontSize: 13, color: Theme.of(context).colorScheme.onSurface)),
            const SizedBox(height: 8),
            PasswordRequirementRow(label: 'At least 8 characters long', isMet: _hasMinLength),
            PasswordRequirementRow(label: 'Includes uppercase & lowercase letters', isMet: _hasMixedCase),
            PasswordRequirementRow(label: 'Includes at least one number', isMet: _hasNumber),
            PasswordRequirementRow(label: 'Includes a special character (e.g. ! @ #)', isMet: _hasSpecial),
          ],
        ),
      );

  String? _newValidator(String? v) {
    if (v == null || v.length < 8) return 'Use at least 8 characters';
    if (!_hasMixedCase) return 'Use uppercase and lowercase letters';
    if (!_hasNumber) return 'Include at least one number';
    if (!_hasSpecial) return 'Include at least one special character';
    return null;
  }

  String? _confirmValidator(String? v) => v != _newController.text ? 'Passwords do not match' : null;

  void _update() {
    if (!_formKey.currentState!.validate()) return;
    Get.showSnackbar(const GetSnackBar(message: 'Password updated.', snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 3)));
  }
}
