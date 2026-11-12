import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:famous_gadget/view/utils/app_text_styles.dart';
import 'package:famous_gadget/view/utils/assets_path.dart';
import 'package:flutter/material.dart';

class LoginWelcomeBanner extends StatelessWidget {
  const LoginWelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220,
      padding: const EdgeInsets.all(24),
      color: AppColors.navyDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AssetsPath.loginLogo,
            width: 160,
            height: 40,
            fit: BoxFit.contain,
          ),
          Column(
            children: [
              Text(
                'Welcome Back',
                style: AppTextStyles.h2.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.surface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Login to unlock premium gadget benefits',
                textAlign: TextAlign.center,
                style: AppTextStyles.caption.copyWith(
                  fontSize: 13,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
