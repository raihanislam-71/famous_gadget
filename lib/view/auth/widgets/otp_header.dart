import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:famous_gadget/view/utils/app_text_styles.dart';
import 'package:famous_gadget/view/utils/assets_path.dart';
import 'package:flutter/material.dart';

class OtpHeader extends StatelessWidget {
  const OtpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 20),
      color: AppColors.navyDark,
      child: Column(
        children: [
          Image.asset(
            AssetsPath.loginLogo,
            width: 140,
            height: 35,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 21),
          Text(
            'Verify Phone Number',
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
}
