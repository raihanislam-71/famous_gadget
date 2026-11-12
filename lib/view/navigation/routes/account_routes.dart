import 'package:get/get.dart';
import '../../../models/saved_address.dart';
import '../../auth/login_screen.dart';
import '../../auth/otp_verification_screen.dart';
import '../../auth/register_screen.dart';
import '../../profile/add_address_screen.dart';
import '../../profile/change_password_screen.dart';
import '../../profile/edit_profile_screen.dart';
import '../../profile/my_addresses_screen.dart';
import '../../profile/profile_screen.dart';
import '../../wishlist/wishlist_screen.dart';
import '../app_navigation.dart';
import 'route_helpers.dart';

class AccountRoutes {
  AccountRoutes._();

  static List<GetPage<void>> get pages => [
        GetPage<void>(
          name: AppRoutes.account,
          page: () => RouteHelpers.webPage(const ProfileScreen()),
        ),
        GetPage<void>(
          name: AppRoutes.login,
          page: () => RouteHelpers.webPage(
            LoginScreen(
              onLoginSuccess: RouteHelpers.callbackArgument('onLoginSuccess') ??
                  RouteHelpers.finishDirectLogin,
              onRegisterSuccess:
                  RouteHelpers.callbackArgument('onRegisterSuccess') ??
                      RouteHelpers.finishDirectLogin,
            ),
          ),
        ),
        GetPage<void>(
          name: AppRoutes.register,
          page: () => RouteHelpers.webPage(
            RegisterScreen(
              onRegisterSuccess:
                  RouteHelpers.callbackArgument('onRegisterSuccess') ??
                      RouteHelpers.finishDirectLogin,
            ),
          ),
        ),
        GetPage<void>(
          name: AppRoutes.otp,
          page: () => RouteHelpers.webPage(
            OtpVerificationScreen(
              phoneNumber: RouteHelpers.stringArgument('phoneNumber'),
              onVerified: RouteHelpers.callbackArgument('onVerified') ??
                  RouteHelpers.finishDirectLogin,
            ),
          ),
        ),
        GetPage<void>(
          name: AppRoutes.editProfile,
          page: () => RouteHelpers.webPage(const EditProfileScreen()),
        ),
        GetPage<void>(
          name: AppRoutes.changePassword,
          page: () => RouteHelpers.webPage(const ChangePasswordScreen()),
        ),
        GetPage<void>(
          name: AppRoutes.addresses,
          page: () => RouteHelpers.webPage(const MyAddressesScreen()),
        ),
        GetPage<SavedAddress>(
          name: AppRoutes.addressForm,
          page: () => RouteHelpers.webPage(
            AddAddressScreen(
              address: RouteHelpers.objectArgument('address') is SavedAddress
                  ? RouteHelpers.objectArgument('address') as SavedAddress
                  : null,
            ),
          ),
        ),
        GetPage<void>(
          name: AppRoutes.wishlist,
          page: () => RouteHelpers.webPage(const WishlistScreen()),
        ),
      ];
}
