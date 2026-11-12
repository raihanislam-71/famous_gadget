import 'package:flutter/material.dart';
import 'app_navigation.dart';
import '../utils/assets_path.dart';
import 'package:get/get.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key, this.width = 156});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Famous Gadget home',
      child: InkWell(
        onTap: () => AppRoutes.to<void>(
          route: AppRoutes.home,
          mobileBuilder: () => const SizedBox.shrink(),
        ),
        child: SizedBox(
          width: width,
          height: 40,
          child: Row(
            children: [
              Image.asset(AssetsPath.appLogo, width: 42, fit: BoxFit.contain),
              const SizedBox(width: 6),
              Expanded(
                child: Image.asset(
                  AssetsPath.appName,
                  fit: BoxFit.contain,
                  color: Get.theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
