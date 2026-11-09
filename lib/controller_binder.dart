import 'package:bdcalling_class/controllers/bottom_nav_controller.dart';
import 'package:bdcalling_class/controllers/auth_controller.dart';
import 'package:bdcalling_class/controllers/cart_controller.dart';
import 'package:bdcalling_class/controllers/product_cart_button_controller.dart';
import 'package:bdcalling_class/controllers/profile_controller.dart';
import 'package:bdcalling_class/controllers/theme_controller.dart';
import 'package:bdcalling_class/controllers/review_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(BottomNavController());
    Get.put(CartController());
    Get.put(ProfileController());
    Get.put(ThemeController());
    Get.put(ReviewController());
    Get.put(ProductCartButtonController());
  }
}
