import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:famous_gadget/view/utils/app_text_styles.dart';
import 'package:famous_gadget/view/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../controllers/profile_controller.dart';


class EditProfileAvatar extends StatelessWidget {
  const EditProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
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
}
