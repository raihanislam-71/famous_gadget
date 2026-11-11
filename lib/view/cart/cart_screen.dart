import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/bottom_nav_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../models/cart_item.dart';
import '../checkout/checkout_delivery_screen.dart';
import '../navigation/app_navigation.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/app_buttons.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final isWideLayout = MediaQuery.sizeOf(context).width >= 900;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: theme.scaffoldBackgroundColor,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
      child: GetBuilder<CartController>(
        builder: (controller) => Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            elevation: 0,
            scrolledUnderElevation: 0,
            toolbarHeight: 60,
            titleSpacing: 16,
            title: Text(
              'My Cart (${controller.totalItemCount} Items)',
              style: AppTextStyles.h2.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: SafeArea(
            top: false,
            child: controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : controller.errorMessage != null
                ? _CartLoadError(
                    message: controller.errorMessage!,
                    onRetry: controller.loadCart,
                  )
                : controller.items.isEmpty
                ? _EmptyCart()
                : _PopulatedCart(
                    controller: cartController,
                    items: controller.items,
                    isWideLayout: isWideLayout,
                  ),
          ),
          bottomNavigationBar:
              controller.items.isEmpty ||
                  controller.isLoading ||
                  controller.errorMessage != null
              ? null
              : isWideLayout
              ? null
              : _CartSummary(controller: cartController),
        ),
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: AppColors.softPeach,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 44,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Your Cart is Empty',
              textAlign: TextAlign.center,
              style: AppTextStyles.h2.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Looks like you haven't added any gadgets yet.\n"
              'Explore our latest collection now!',
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(
                color: AppColors.secondaryText,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 220,
              child: AppPrimaryButton(
                label: 'Start Shopping',
                height: 52,
                onPressed: () {
                  Get.find<BottomNavController>().changeIndex(0);
                },
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 280,
              child: OutlinedButton(
                onPressed: () {
                  AppRoutes.to<void>(
                    route: AppRoutes.checkoutDelivery,
                    mobileBuilder: () => const CheckoutDeliveryScreen(),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: const StadiumBorder(),
                  textStyle: AppTextStyles.button,
                ),
                child: const Text('Checkout (Cash on Delivery)'),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Demo checkout preview',
              style: AppTextStyles.caption.copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartLoadError extends StatelessWidget {
  const _CartLoadError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: AppColors.dangerRed,
              size: 40,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 12),
            TextButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}

class _PopulatedCart extends StatelessWidget {
  const _PopulatedCart({
    required this.controller,
    required this.items,
    required this.isWideLayout,
  });

  final CartController controller;
  final List<CartItem> items;
  final bool isWideLayout;

  @override
  Widget build(BuildContext context) {
    Widget itemList() => ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = items[index];
        return _CartItemCard(
          item: item,
          onDecrease: () => controller.updateQuantity(item.id, -1),
          onIncrease: () => controller.updateQuantity(item.id, 1),
          onRemove: () => controller.removeProduct(item.id),
        );
      },
    );

    if (!isWideLayout) return itemList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: itemList()),
        SizedBox(
          width: 360,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
            child: _CartSummary(controller: controller),
          ),
        ),
      ],
    );
  }
}

class _CartItemCard extends StatelessWidget {
  const _CartItemCard({
    required this.item,
    required this.onDecrease,
    required this.onIncrease,
    required this.onRemove,
  });

  final CartItem item;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              item.imagePath,
              width: 88,
              height: 88,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => Container(
                width: 88,
                height: 88,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Icon(
                  Icons.devices_other,
                  color: AppColors.secondaryText,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.uiSemibold.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 6),
                Text(
                  _formatPrice(item.unitPrice),
                  style: AppTextStyles.badge.copyWith(
                    fontSize: 15,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _QuantityButton(icon: Icons.remove, onPressed: onDecrease),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '${item.quantity}',
                        style: AppTextStyles.badge.copyWith(fontSize: 14),
                      ),
                    ),
                    _QuantityButton(icon: Icons.add, onPressed: onIncrease),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onRemove,
            tooltip: 'Remove from cart',
            icon: const Icon(
              Icons.delete_outline,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(double price) =>
      '৳${NumberFormat('#,##0').format(price)}';
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  const _CartSummary({required this.controller});

  final CartController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal', style: AppTextStyles.body),
                Text(
                  '৳${NumberFormat('#,##0').format(controller.subtotal)}',
                  style: AppTextStyles.badge.copyWith(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            AppPrimaryButton(
              label: 'Checkout (Cash on Delivery)',
              height: 48,
              onPressed: () {
                AppRoutes.to<void>(
                  route: AppRoutes.checkoutDelivery,
                  mobileBuilder: () => const CheckoutDeliveryScreen(),
                );
              },
            ),
            const SizedBox(height: 4),
            Text(
              'Demo checkout preview',
              style: AppTextStyles.caption.copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
