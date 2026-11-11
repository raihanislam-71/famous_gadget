import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/bottom_nav_controller.dart';
import '../navigation/main_bottom_nav_screen.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/assets_path.dart';
import '../widgets/app_buttons.dart';
import 'my_orders_screen.dart';
import '../navigation/app_navigation.dart';

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
                        _buildSuccessIcon(),
                        const SizedBox(height: 24),
                        _buildTitle(context),
                        const SizedBox(height: 24),
                        _buildOrderDetails(),
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

  Widget _buildSuccessIcon() {
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

  Widget _buildTitle(BuildContext context) {
    return Column(
      children: [
        Text(
          'Order Placed Successfully!',
          textAlign: TextAlign.center,
          style: AppTextStyles.h2.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.surface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isPreview
              ? 'Preview only — your order is not submitted until checkout API is connected.'
              : 'We will call you shortly to confirm your delivery address.',
          textAlign: TextAlign.center,
          style: AppTextStyles.body.copyWith(
            fontSize: 14,
            height: 1.4,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderDetails() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            'Order Number',
            isPreview ? '#FG-DEMO' : '#FG-20240315',
            valueStyle: AppTextStyles.badge.copyWith(
              fontSize: 14,
              color: AppColors.surface,
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            'Total Amount',
            '৳26,118',
            valueStyle: AppTextStyles.badge.copyWith(
              fontSize: 14,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            'Payment Method',
            'Cash on Delivery',
            valueStyle: AppTextStyles.body.copyWith(
              fontSize: 13,
              height: 1,
              color: AppColors.surface,
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            'Order Status',
            isPreview ? 'Preview' : 'Processing',
            valueStyle: AppTextStyles.badge.copyWith(
              fontSize: 11,
              color: AppColors.amber,
            ),
            status: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    required TextStyle valueStyle,
    bool status = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.body.copyWith(
            fontSize: 13,
            height: 1,
            color: const Color(0xFF94A3B8),
          ),
        ),
        if (status)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.amber.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(value, style: valueStyle),
          )
        else
          Text(value, style: valueStyle),
      ],
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
