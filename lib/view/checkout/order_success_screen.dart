import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/bottom_nav_controller.dart';
import '../navigation/main_bottom_nav_screen.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/app_buttons.dart';
import 'my_orders_screen.dart';
import '../navigation/app_navigation.dart';
import 'widgets/success/order_details_summary.dart';
import 'widgets/success/order_success_icon.dart';
import 'widgets/success/order_success_title.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key, this.isPreview = false});

  final bool isPreview;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.navyDark,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.navyDark,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.navyDark,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.sizeOf(context).height - 240,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const OrderSuccessIcon(),
                        const SizedBox(height: 24),
                        OrderSuccessTitle(isPreview: isPreview),
                        const SizedBox(height: 24),
                        OrderDetailsSummary(isPreview: isPreview),
                        const SizedBox(height: 24),
                        _buildTimeline(),
                      ],
                    ),
                  ),
                ),
              ),
              _buildActions(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        children: [
          _buildTimelineStep('We call you to confirm order', isCurrent: true),
          const SizedBox(height: 12),
          _buildTimelineStep('We pack and ship your gadget'),
          const SizedBox(height: 12),
          _buildTimelineStep('You pay on delivery (Dhaka/COD)'),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(String label, {bool isCurrent = false}) {
    final color = isCurrent ? AppColors.primary : AppColors.secondaryText;
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.body.copyWith(
              fontSize: 13,
              height: 1,
              color: isCurrent ? AppColors.surface : color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          AppPrimaryButton(
            label: 'Continue Shopping',
            onPressed: _continueShopping,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton(
              onPressed: () => AppRoutes.to<void>(
                route: AppRoutes.orders,
                arguments: {'isPreview': isPreview},
                mobileBuilder: () => MyOrdersScreen(isPreview: isPreview),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.surface,
                side: const BorderSide(color: AppColors.surface),
                shape: const StadiumBorder(),
                textStyle: AppTextStyles.button,
              ),
              child: const Text('View My Orders'),
            ),
          ),
        ],
      ),
    );
  }

  void _continueShopping() {
    Get.find<BottomNavController>().changeIndex(0);
    AppRoutes.offAll<void>(
      route: AppRoutes.home,
      mobileBuilder: () => const MainBottomNavScreen(),
    );
  }
}
