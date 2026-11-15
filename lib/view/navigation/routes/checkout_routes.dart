import 'package:get/get.dart';
import '../../checkout/checkout_confirmation_screen.dart';
import '../../checkout/checkout_delivery_screen.dart';
import '../../checkout/my_orders_screen.dart';
import '../../checkout/order_detail_screen.dart';
import '../../checkout/order_success_screen.dart';
import '../app_navigation.dart';
import 'route_helpers.dart';

class CheckoutRoutes {
  CheckoutRoutes._();

  static List<GetPage<void>> get pages => [
        GetPage<void>(
          name: AppRoutes.orders,
          page: () => RouteHelpers.webPage(
              MyOrdersScreen(isPreview: RouteHelpers.boolArgument('isPreview'))),
        ),
        GetPage<void>(
          name: '${AppRoutes.orderDetails}/:orderNumber',
          page: () => RouteHelpers.webPage(
            OrderDetailScreen(
              orderNumber: RouteHelpers.stringArgument('orderNumber'),
              status: RouteHelpers.stringArgument('status'),
              isPreview: RouteHelpers.boolArgument('isPreview'),
            ),
          ),
        ),
        GetPage<void>(
          name: AppRoutes.checkoutDelivery,
          page: () => RouteHelpers.webPage(const CheckoutDeliveryScreen()),
        ),
        GetPage<void>(
          name: AppRoutes.checkoutConfirmation,
          page: () => RouteHelpers.webPage(
            CheckoutConfirmationScreen(
              deliveryAddress: RouteHelpers.stringArgument('deliveryAddress'),
            ),
          ),
        ),
        GetPage<void>(
          name: AppRoutes.orderSuccess,
          page: () => RouteHelpers.webPage(OrderSuccessScreen(
              isPreview: RouteHelpers.boolArgument('isPreview'))),
        ),
      ];
}
