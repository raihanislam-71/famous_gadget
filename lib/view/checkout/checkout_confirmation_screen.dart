import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/assets_path.dart';
import '../widgets/app_buttons.dart';
import 'checkout_delivery_screen.dart';
import 'order_success_screen.dart';
import '../navigation/app_navigation.dart';

class CheckoutConfirmationScreen extends StatefulWidget {
  const CheckoutConfirmationScreen({super.key, required this.deliveryAddress});

  final String deliveryAddress;

  @override
  State<CheckoutConfirmationScreen> createState() =>
      _CheckoutConfirmationScreenState();
}

class _CheckoutConfirmationScreenState
    extends State<CheckoutConfirmationScreen> {
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.pageBackground,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildAppBar(),
              const CheckoutStepIndicator(activeStep: 2),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                  children: [
                    _buildSectionTitle('PAYMENT METHOD'),
                    const SizedBox(height: 16),
                    _buildPaymentCard(),
                    const SizedBox(height: 16),
                    _buildSectionTitle('SHIPPING METHOD'),
                    const SizedBox(height: 16),
                    _buildShippingCard(),
                    const SizedBox(height: 16),
                    _buildOrderNotes(),
                    const SizedBox(height: 16),
                    _buildSectionTitle('ORDER ITEMS'),
                    const SizedBox(height: 16),
                    _buildOrderItems(),
                    const SizedBox(height: 16),
                    _buildBill(),
                  ],
                ),
              ),
              _buildPlaceOrderButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: kIsWeb ? null : () => Get.back<void>(),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!kIsWeb) ...[
                  Icon(
                    CupertinoIcons.back,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  const SizedBox(width: 12),
                ],
                Text(
                  'Order Confirmation',
                  style: AppTextStyles.h2.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Text(
    title,
    style: AppTextStyles.badge.copyWith(
      fontSize: 14,
      color: Theme.of(context).colorScheme.onSurface,
    ),
  );

  Widget _buildPaymentCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: AppColors.primary, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.softPeach,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                AssetsPath.checkoutCodBanknote,
                width: 20,
                height: 20,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cash on Delivery (COD)',
                  style: AppTextStyles.badge.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  'Pay cash when you receive your gadget.',
                  style: AppTextStyles.caption.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: AppColors.successGreen,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                AssetsPath.checkoutConfirmCheck,
                width: 10,
                height: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: AppColors.primary, width: 1.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _buildRadio(true),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Express Delivery (Dhaka Only)',
                  style: AppTextStyles.badge.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  'Same day delivery inside Dhaka zones',
                  style: AppTextStyles.caption.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            '৳120',
            style: AppTextStyles.badge.copyWith(
              fontSize: 14,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadio(bool selected) => Container(
    width: 18,
    height: 18,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: selected ? AppColors.primary : AppColors.border,
        width: selected ? 5 : 1.5,
      ),
    ),
  );

  Widget _buildOrderNotes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Order Notes (Optional)',
          style: AppTextStyles.badge.copyWith(fontSize: 13),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 44,
          child: TextField(
            controller: _notesController,
            style: AppTextStyles.body.copyWith(
              fontSize: 14,
              height: 1,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              hintText: 'e.g. Leave package with guard',
              hintStyle: AppTextStyles.body.copyWith(
                fontSize: 14,
                height: 1,
                color: AppColors.secondaryText,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: _inputBorder(),
              enabledBorder: _inputBorder(),
              focusedBorder: _inputBorder(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItems() {
    return Column(
      children: [
        _buildOrderItem(
          image: AssetsPath.checkoutAnkerImage,
          name: 'Anker Soundcore R50i',
          detail: 'Qty: 1 • Navy Blue',
          price: '৳1,999',
        ),
        const SizedBox(height: 8),
        _buildOrderItem(
          image: AssetsPath.checkoutOnePlusImage,
          name: 'OnePlus Nord CE 3 Lite',
          detail: 'Qty: 1 • Pastel Lime',
          price: '৳24,499',
        ),
      ],
    );
  }

  Widget _buildOrderItem({
    required String image,
    required String name,
    required String detail,
    required String price,
  }) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(image, width: 40, height: 40, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.badge.copyWith(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(detail, style: AppTextStyles.caption.copyWith(fontSize: 11)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          price,
          style: AppTextStyles.badge.copyWith(
            fontSize: 13,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildBill() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildBillRow('Subtotal', '৳26,498'),
          const SizedBox(height: 8),
          _buildBillRow('Shipping Fee', '৳120'),
          const SizedBox(height: 8),
          _buildBillRow(
            'Promo Discount',
            '-৳500',
            valueColor: AppColors.successGreen,
          ),
          const SizedBox(height: 8),
          SvgPicture.asset(AssetsPath.checkoutBillDivider),
          const SizedBox(height: 8),
          _buildBillRow(
            'Total Amount',
            '৳26,118',
            isTotal: true,
            valueColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildBillRow(
    String label,
    String value, {
    bool isTotal = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTextStyles.uiSemibold.copyWith(fontSize: 16)
              : AppTextStyles.body.copyWith(
                  fontSize: 13,
                  height: 1,
                  color: AppColors.secondaryText,
                ),
        ),
        Text(
          value,
          style: isTotal
              ? AppTextStyles.h2.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: valueColor,
                )
              : AppTextStyles.body.copyWith(
                  fontSize: 13,
                  height: 1,
                  color: valueColor ?? Theme.of(context).colorScheme.onSurface,
                ),
        ),
      ],
    );
  }

  Widget _buildPlaceOrderButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: SafeArea(
        top: false,
        child: AppPrimaryButton(label: 'Place Order', onPressed: _placeOrder),
      ),
    );
  }

  OutlineInputBorder _inputBorder({Color color = AppColors.border}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color),
      );

  void _placeOrder() {
    AppRoutes.off<void>(
      route: AppRoutes.orderSuccess,
      arguments: const {'isPreview': true},
      mobileBuilder: () => const OrderSuccessScreen(isPreview: true),
    );
  }
}
