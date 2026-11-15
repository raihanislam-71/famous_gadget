import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:famous_gadget/view/utils/app_text_styles.dart';
import 'package:famous_gadget/view/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordRequirementRow extends StatelessWidget {
  const PasswordRequirementRow({
    super.key,
    required this.label,
    required this.isMet,
  });

  final String label;
  final bool isMet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
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
      ),
    );
  }
}
