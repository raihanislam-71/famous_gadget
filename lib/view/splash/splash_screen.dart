import 'package:bdcalling_class/presentation/ui/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../utils/app_colors.dart';
import 'main_bottom_nav_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.off(() => const MainBottomNavScreen());
  }

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              const Spacer(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 42,
                      vertical: 22,
                    ),
                    child: Image.asset(AssetsPath.splashLogo),
                  ),
                  const SizedBox(
                    width: 170,
                    child: Text(
                      "Gadgets you love. Cash on Delivery BD.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white60),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const SizedBox(
                width: 150,
                child: LinearProgressIndicator(
                  color: AppColors.themeColor,
                  backgroundColor: Colors.white24,
                  minHeight: 5,
                ),
              ),
              const SizedBox(height: 16),
              const Text("Version 1.0.0", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
