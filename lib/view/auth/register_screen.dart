import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/assets_path.dart';
import '../widgets/app_buttons.dart';
import '../navigation/app_navigation.dart';
import 'otp_verification_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.onRegisterSuccess});

  final VoidCallback onRegisterSuccess;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _acceptTerms = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
        backgroundColor: AppColors.pageBackground,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _buildNameField(
                                label: 'First Name',
                                controller: _firstNameController,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildNameField(
                                label: 'Last Name',
                                controller: _lastNameController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildPhoneField(),
                        const SizedBox(height: 16),
                        _buildEmailField(),
                        const SizedBox(height: 16),
                        _buildPasswordField(),
                        const SizedBox(height: 12),
                        _buildTermsRow(),
                        const SizedBox(height: 16),
                        AppPrimaryButton(label: 'Register', onPressed: _submit),
                        const SizedBox(height: 16),
                        _buildLoginPrompt(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 160,
      padding: const EdgeInsets.all(20),
      color: AppColors.navyDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AssetsPath.loginLogo,
            width: 140,
            height: 35,
            fit: BoxFit.contain,
          ),
          Text(
            'Create Account',
            style: AppTextStyles.h2.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.surface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField({
    required String label,
    required TextEditingController controller,
  }) {
    return _RegisterField(
      label: label,
      child: TextFormField(
        controller: controller,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.next,
        validator: (value) =>
            value == null || value.trim().isEmpty ? 'Required' : null,
        style: AppTextStyles.body.copyWith(fontSize: 13, height: 1),
        decoration: _inputDecoration(hintText: label),
      ),
    );
  }

  Widget _buildPhoneField() {
    return _RegisterField(
      label: 'Phone Number',
      child: TextFormField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        validator: (value) {
          final phone = value?.trim() ?? '';
          return phone.length == 10 && phone.startsWith('1')
              ? null
              : 'Enter a valid phone number';
        },
        style: AppTextStyles.body.copyWith(fontSize: 13, height: 1),
        decoration: _inputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 14, right: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '+880',
                  style: AppTextStyles.uiSemibold.copyWith(fontSize: 13),
                ),
                const SizedBox(width: 8),
                Container(width: 1, height: 18, color: AppColors.border),
                const SizedBox(width: 8),
              ],
            ),
          ),
          hintText: '1XXXXXXXXX',
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return _RegisterField(
      label: 'Email Address',
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: (value) {
          final email = value?.trim() ?? '';
          return email.contains('@') && email.contains('.')
              ? null
              : 'Enter a valid email address';
        },
        style: AppTextStyles.body.copyWith(fontSize: 13, height: 1),
        decoration: _inputDecoration(hintText: 'example@gmail.com'),
      ),
    );
  }

  Widget _buildPasswordField() {
    return _RegisterField(
      label: 'Password',
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        textInputAction: TextInputAction.done,
        validator: (value) =>
            (value?.length ?? 0) >= 8 ? null : 'Use at least 8 characters',
        style: AppTextStyles.body.copyWith(fontSize: 13, height: 1),
        decoration: _inputDecoration(
          hintText: 'Enter password',
          suffixIcon: IconButton(
            onPressed: () {
              setState(() => _obscurePassword = !_obscurePassword);
            },
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 18,
              color: AppColors.secondaryText,
            ),
          ),
        ),
        onFieldSubmitted: (_) => _submit(),
      ),
    );
  }

  Widget _buildTermsRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 18,
          height: 18,
          child: Checkbox(
            value: _acceptTerms,
            onChanged: (value) {
              setState(() => _acceptTerms = value ?? false);
            },
            activeColor: AppColors.primary,
            checkColor: AppColors.surface,
            side: const BorderSide(color: AppColors.border),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'I agree to the Terms & Conditions and Privacy Policy',
                style: AppTextStyles.body.copyWith(fontSize: 12, height: 1.2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoginPrompt() {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: AppTextStyles.caption.copyWith(fontSize: 13),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            foregroundColor: AppColors.primary,
            textStyle: AppTextStyles.body.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: const Text('Login'),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.border),
    );

    return InputDecoration(
      constraints: const BoxConstraints(minHeight: 44),
      hintText: hintText,
      hintStyle: AppTextStyles.body.copyWith(
        fontSize: 13,
        height: 1,
        color: AppColors.secondaryText,
      ),
      prefixIcon: prefixIcon,
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 44),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14),
      border: border,
      enabledBorder: border,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      errorStyle: const TextStyle(fontSize: 10, height: 1),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Agree to the Terms & Conditions to continue.'),
        ),
      );
      return;
    }

    final phoneNumber = _phoneController.text.trim();
    AppRoutes.to<void>(
      route: AppRoutes.otp,
      arguments: {
        'phoneNumber': phoneNumber,
        'onVerified': widget.onRegisterSuccess,
      },
      mobileBuilder: () => OtpVerificationScreen(
        phoneNumber: phoneNumber,
        onVerified: widget.onRegisterSuccess,
      ),
    );
  }
}

class _RegisterField extends StatelessWidget {
  const _RegisterField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: AppTextStyles.badge.copyWith(
            fontSize: 12,
            color: AppColors.navyDark,
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}
