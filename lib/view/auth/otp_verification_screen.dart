import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/app_buttons.dart';
import 'widgets/otp_header.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
    this.onVerified,
  });

  final String phoneNumber;
  final VoidCallback? onVerified;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _pinController = TextEditingController();
  Timer? _countdownTimer;
  int _resendSeconds = 30;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds <= 1) {
        timer.cancel();
        setState(() => _resendSeconds = 0);
      } else {
        setState(() => _resendSeconds--);
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.navyDark,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              const OtpHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      _buildInstruction(),
                      const SizedBox(height: 32),
                      _buildPinInput(),
                      const SizedBox(height: 32),
                      _buildResendSection(),
                      const SizedBox(height: 32),
                      AppPrimaryButton(label: 'Verify', onPressed: _verify),
                      const SizedBox(height: 28),
                      TextButton(
                        onPressed: () => Get.back<void>(),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          textStyle: AppTextStyles.uiSemibold.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        child: const Text('Change Phone Number'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstruction() {
    return Text.rich(
      TextSpan(
        text: 'Enter the 4-digit verification code for ',
        style: AppTextStyles.body.copyWith(
          color: AppColors.secondaryText,
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: '+880 ${widget.phoneNumber}',
            style: AppTextStyles.body.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w700,
              height: 1.5,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPinInput() {
    final defaultTheme = PinTheme(
      width: 54,
      height: 54,
      textStyle: AppTextStyles.h2.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return Pinput(
      length: 4,
      controller: _pinController,
      autofocus: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      animationDuration: Duration.zero,
      defaultPinTheme: defaultTheme,
      submittedPinTheme: defaultTheme,
      focusedPinTheme: defaultTheme.copyWith(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(color: AppColors.primary, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      separatorBuilder: (_) => const SizedBox(width: 16),
      showCursor: true,
      cursor: Container(width: 2, height: 20, color: AppColors.primary),
    );
  }

  Widget _buildResendSection() {
    final minutes = (_resendSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_resendSeconds % 60).toString().padLeft(2, '0');
    final canResend = _resendSeconds == 0;

    return Column(
      children: [
        Text.rich(
          TextSpan(
            text: _resendSeconds > 0
                ? 'Resend code in '
                : "Didn't receive a code? ",
            style: AppTextStyles.caption.copyWith(fontSize: 13),
            children: _resendSeconds > 0
                ? [
                    TextSpan(
                      text: '$minutes:$seconds',
                      style: AppTextStyles.uiSemibold.copyWith(fontSize: 13),
                    ),
                  ]
                : null,
          ),
        ),
        TextButton(
          onPressed: canResend ? _resendCode : null,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            disabledForegroundColor: AppColors.primary.withValues(alpha: 0.4),
            padding: const EdgeInsets.symmetric(vertical: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            textStyle: AppTextStyles.uiSemibold.copyWith(fontSize: 14),
          ),
          child: const Text('Resend Code'),
        ),
      ],
    );
  }

  void _verify() {
    if (_pinController.text.length != 4) {
      _showMessage('Enter any 4 digits to continue in demo mode.');
      return;
    }

    widget.onVerified?.call();
    if (widget.onVerified == null) {
      _showMessage('Demo verification complete. No API request was made.');
    }
  }

  void _resendCode() {
    setState(() => _resendSeconds = 30);
    _countdownTimer?.cancel();
    _startTimer();
    _showMessage('Demo mode: no verification code was sent.');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
