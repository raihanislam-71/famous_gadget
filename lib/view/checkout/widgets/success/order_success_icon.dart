import 'package:famous_gadget/view/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderSuccessIcon extends StatelessWidget {
  const OrderSuccessIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Order placed successfully',
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutBack,
        builder: (context, scale, child) => Opacity(
          opacity: scale.clamp(0, 1).toDouble(),
          child: Transform.scale(scale: scale, child: child),
        ),
        child: SvgPicture.asset(
          AssetsPath.orderSuccessAnimation,
          width: 80,
          height: 80,
        ),
      ),
    );
  }
}
