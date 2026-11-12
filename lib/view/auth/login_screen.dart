import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/app_buttons.dart';
import '../navigation/app_navigation.dart';
import 'otp_verification_screen.dart';
import 'register_screen.dart';
import 'widgets/login_welcome_banner.dart';
import 'widgets/phone_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.onLoginSuccess,
    required this.onRegisterSuccess,
  });

  final VoidCallback onLoginSuccess;
  final VoidCallback onRegisterSuccess;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
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
        body: SafeArea(
          child: Column(
            children: [
              const LoginWelcomeBanner(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Phone Number',
                          style: AppTextStyles.badge.copyWith(
                            fontSize: 13,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        PhoneField(
                          controller: _phoneController,
                          onSubmitted: _submit,
                        ),
                        const SizedBox(height: 20),
                        AppPrimaryButton(label: 'Login', onPressed: _submit),
                        const SizedBox(height: 8),
                        Text(
                          'Demo login: use any valid phone number and any 4-digit code.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.caption.copyWith(fontSize: 11),
                        ),
                        const SizedBox(height: 20),
                        _buildRegisterPrompt(),
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

  Widget _buildRegisterPrompt() {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: AppTextStyles.caption.copyWith(fontSize: 13),
        ),
        TextButton(
          onPressed: () {
            AppRoutes.to<void>(
              route: AppRoutes.register,
              arguments: {'onRegisterSuccess': widget.onRegisterSuccess},
              mobileBuilder: () =>
                  RegisterScreen(onRegisterSuccess: widget.onRegisterSuccess),
            );
          },
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
          child: const Text('Register'),
        ),
      ],
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid phone number.')),
      );
      return;
    }

    final phoneNumber = _phoneController.text.trim();
    AppRoutes.to<void>(
      route: AppRoutes.otp,
      arguments: {
        'phoneNumber': phoneNumber,
        'onVerified': widget.onLoginSuccess,
      },
      mobileBuilder: () => OtpVerificationScreen(
        phoneNumber: phoneNumber,
        onVerified: widget.onLoginSuccess,
      ),
    );
  }
}
