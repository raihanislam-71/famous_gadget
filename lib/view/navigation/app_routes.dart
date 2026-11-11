import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../models/saved_address.dart';
import '../auth/login_screen.dart';
import '../auth/otp_verification_screen.dart';
import '../auth/register_screen.dart';
import '../cart/cart_screen.dart';
import '../category/category_screen.dart';
import '../category/product_by_category_screen.dart';
import '../category/product_list_screen.dart';
import '../category/sub_category_screen.dart';
import '../checkout/checkout_confirmation_screen.dart';
import '../checkout/checkout_delivery_screen.dart';
import '../checkout/my_orders_screen.dart';
import '../checkout/order_detail_screen.dart';
import '../checkout/order_success_screen.dart';
import '../home/web_home_screen.dart';
import '../navigation/web_page_frame.dart';
import '../product_details/out_of_stock_product_details_screen.dart';
import '../product_details/product_details_screen.dart';
import '../profile/add_address_screen.dart';
import '../profile/change_password_screen.dart';
import '../profile/edit_profile_screen.dart';
import '../profile/my_addresses_screen.dart';
import '../profile/profile_screen.dart';
import '../review/review_screen.dart';
import '../wishlist/wishlist_screen.dart';
import 'app_navigation.dart';

class AppRoutePages {
  AppRoutePages._();

  static String get initialWebRoute {
    final path = Uri.base.path;
    if (path.isNotEmpty && path != '/') return path;

    final fragment = Uri.base.fragment;
    if (fragment.startsWith('/')) {
      return fragment.split('?').first;
    }
    return AppRoutes.home;
  }

  static List<GetPage<void>> get pages => [
    GetPage<void>(name: AppRoutes.home, page: () => const WebHomeScreen()),
    GetPage<void>(
      name: AppRoutes.categories,
      page: () => _webPage(const CategoryScreen()),
    ),
    GetPage<void>(
      name: '${AppRoutes.subCategory}/:categoryName',
      page: () => _webPage(
        SubCategoryScreen(categoryName: _stringArgument('categoryName')),
      ),
    ),
    GetPage<void>(
      name: '${AppRoutes.products}/:categoryName',
      page: () => _webPage(
        ProductByCategoryScreen(categoryName: _stringArgument('categoryName')),
      ),
    ),
    GetPage<void>(
      name: AppRoutes.products,
      page: () => _webPage(const ProductListScreen(title: 'All Products')),
    ),
    GetPage<void>(
      name: AppRoutes.search,
      page: () => _webPage(
        ProductListScreen(
          title: 'Search Products',
          initialSearchActive: true,
          initialSearchQuery: _stringArgument('searchQuery'),
        ),
      ),
    ),
    GetPage<void>(
      name: '${AppRoutes.productDetails}/:productId',
      page: () => _webPage(
        ProductDetailsScreen(
          productId: _stringArgument('productId', fallback: 'anker-r50i'),
        ),
      ),
    ),
    GetPage<void>(
      name: '/products/detail/:productId',
      page: () => _webPage(
        ProductDetailsScreen(
          productId: _stringArgument('productId', fallback: 'anker-r50i'),
        ),
      ),
    ),
    GetPage<void>(
      name: AppRoutes.productDetails,
      page: () => _webPage(
        ProductDetailsScreen(
          productId: _stringArgument('productId', fallback: 'anker-r50i'),
        ),
      ),
    ),
    GetPage<void>(
      name: '/products/detail',
      page: () => _webPage(
        ProductDetailsScreen(
          productId: _stringArgument('productId', fallback: 'anker-r50i'),
        ),
      ),
    ),
    GetPage<void>(
      name: '${AppRoutes.outOfStockProduct}/:productId',
      page: () => _webPage(
        OutOfStockProductDetailsScreen(
          productId: _stringArgument('productId', fallback: 'sony-xm5'),
        ),
      ),
    ),
    GetPage<void>(
      name: '/products/out-of-stock-details/:productId',
      page: () => _webPage(
        OutOfStockProductDetailsScreen(
          productId: _stringArgument('productId', fallback: 'sony-xm5'),
        ),
      ),
    ),
    GetPage<void>(
      name: AppRoutes.outOfStockProduct,
      page: () => _webPage(
        OutOfStockProductDetailsScreen(
          productId: _stringArgument('productId', fallback: 'sony-xm5'),
        ),
      ),
    ),
    GetPage<void>(
      name: '/products/out-of-stock-details',
      page: () => _webPage(
        OutOfStockProductDetailsScreen(
          productId: _stringArgument('productId', fallback: 'sony-xm5'),
        ),
      ),
    ),
    GetPage<void>(
      name: AppRoutes.cart,
      page: () => _webPage(const CartScreen()),
    ),
    GetPage<void>(
      name: AppRoutes.account,
      page: () => _webPage(const ProfileScreen()),
    ),
    GetPage<void>(
      name: AppRoutes.login,
      page: () => _webPage(
        LoginScreen(
          onLoginSuccess:
              _callbackArgument('onLoginSuccess') ?? _finishDirectLogin,
          onRegisterSuccess:
              _callbackArgument('onRegisterSuccess') ?? _finishDirectLogin,
        ),
      ),
    ),
    GetPage<void>(
      name: AppRoutes.register,
      page: () => _webPage(
        RegisterScreen(
          onRegisterSuccess:
              _callbackArgument('onRegisterSuccess') ?? _finishDirectLogin,
        ),
      ),
    ),
    GetPage<void>(
      name: AppRoutes.otp,
      page: () => _webPage(
        OtpVerificationScreen(
          phoneNumber: _stringArgument('phoneNumber'),
          onVerified: _callbackArgument('onVerified') ?? _finishDirectLogin,
        ),
      ),
    ),
    GetPage<void>(
      name: AppRoutes.editProfile,
      page: () => _webPage(const EditProfileScreen()),
    ),
    GetPage<void>(
      name: AppRoutes.changePassword,
      page: () => _webPage(const ChangePasswordScreen()),
    ),
    GetPage<void>(
      name: AppRoutes.addresses,
      page: () => _webPage(const MyAddressesScreen()),
    ),
    GetPage<SavedAddress>(
      name: AppRoutes.addressForm,
      page: () => _webPage(
        AddAddressScreen(
          address: _objectArgument('address') is SavedAddress
              ? _objectArgument('address') as SavedAddress
              : null,
        ),
      ),
    ),
    GetPage<void>(
      name: AppRoutes.orders,
      page: () =>
          _webPage(MyOrdersScreen(isPreview: _boolArgument('isPreview'))),
    ),
    GetPage<void>(
      name: '${AppRoutes.orderDetails}/:orderNumber',
      page: () => _webPage(
        OrderDetailScreen(
          orderNumber: _stringArgument('orderNumber'),
          status: _stringArgument('status'),
          isPreview: _boolArgument('isPreview'),
        ),
      ),
    ),
    GetPage<void>(
      name: AppRoutes.wishlist,
      page: () => _webPage(const WishlistScreen()),
    ),
    GetPage<void>(
      name: AppRoutes.checkoutDelivery,
      page: () => _webPage(const CheckoutDeliveryScreen()),
    ),
    GetPage<void>(
      name: AppRoutes.checkoutConfirmation,
      page: () => _webPage(
        CheckoutConfirmationScreen(
          deliveryAddress: _stringArgument('deliveryAddress'),
        ),
      ),
    ),
    GetPage<void>(
      name: AppRoutes.orderSuccess,
      page: () =>
          _webPage(OrderSuccessScreen(isPreview: _boolArgument('isPreview'))),
    ),
    GetPage<void>(
      name: '${AppRoutes.reviews}/:productId',
      page: () => _webPage(
        ReviewScreen(
          productId: _stringArgument('productId', fallback: 'anker-r50i'),
        ),
      ),
    ),
    GetPage<void>(
      name: '/products/review/:productId',
      page: () => _webPage(
        ReviewScreen(
          productId: _stringArgument('productId', fallback: 'anker-r50i'),
        ),
      ),
    ),
    GetPage<void>(
      name: AppRoutes.reviews,
      page: () => _webPage(
        ReviewScreen(
          productId: _stringArgument('productId', fallback: 'anker-r50i'),
        ),
      ),
    ),
  ];

  static Widget _webPage(Widget child) =>
      kIsWeb ? WebPageFrame(child: child) : child;

  static Object? _objectArgument(String key) {
    final arguments = Get.arguments;
    return arguments is Map ? arguments[key] : null;
  }

  static String _stringArgument(String key, {String fallback = ''}) {
    final parameter = Get.parameters[key];
    if (parameter != null) return parameter;
    final value = _objectArgument(key);
    return value is String ? value : fallback;
  }

  static bool _boolArgument(String key) => _objectArgument(key) == true;

  static void Function()? _callbackArgument(String key) {
    final value = _objectArgument(key);
    return value is void Function() ? value : null;
  }

  static void _finishDirectLogin() {
    Get.find<AuthController>().completeDemoAuthentication();
    Get.offAllNamed<void>(AppRoutes.home);
  }
}
