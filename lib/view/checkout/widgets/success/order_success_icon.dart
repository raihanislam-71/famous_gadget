import 'package:famous_gadget/view/utils/app_colors.dart';
import 'package:famous_gadget/view/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class OrderSuccessIcon extends StatelessWidget {
  const OrderSuccessIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.successGreen.withValues(alpha: 0.2),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.successGreen, width: 3),
      ),
      child: Center(
        child: SvgPicture.asset(
          AssetsPath.orderSuccessCircleX,
          width: 36,
          height: 36,
        ),
      ),
    );
  }
}
