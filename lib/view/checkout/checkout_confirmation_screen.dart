import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/assets_path.dart';
import '../widgets/app_buttons.dart';
import 'order_success_screen.dart';
import 'widgets/checkout_step_indicator.dart';
import 'widgets/confirmation/order_bill.dart';
import 'widgets/confirmation/order_item_card.dart';
import 'widgets/confirmation/payment_card.dart';
import 'widgets/confirmation/shipping_card.dart';
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
                    const PaymentCard(),
                    const SizedBox(height: 16),
                    _buildSectionTitle('SHIPPING METHOD'),
                    const SizedBox(height: 16),
                    const ShippingCard(),
                    const SizedBox(height: 16),
                    _buildOrderNotes(),
                    const SizedBox(height: 16),
                    _buildSectionTitle('ORDER ITEMS'),
                    const SizedBox(height: 16),
                    _buildOrderItems(),
                    const SizedBox(height: 16),
                    const OrderBill(),
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
    return const Column(
      children: [
        OrderItemCard(
          image: AssetsPath.checkoutAnkerImage,
          name: 'Anker Soundcore R50i',
          detail: 'Qty: 1 • Navy Blue',
          price: '৳1,999',
        ),
        SizedBox(height: 8),
        OrderItemCard(
          image: AssetsPath.checkoutOnePlusImage,
          name: 'OnePlus Nord CE 3 Lite',
          detail: 'Qty: 1 • Pastel Lime',
          price: '৳24,499',
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
