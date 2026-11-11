import 'package:famous_gadget/controllers/bottom_nav_controller.dart';
import 'package:famous_gadget/controllers/auth_controller.dart';
import 'package:famous_gadget/controllers/cart_controller.dart';
import 'package:famous_gadget/controllers/product_cart_button_controller.dart';
import 'package:famous_gadget/controllers/profile_controller.dart';
import 'package:famous_gadget/controllers/review_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(BottomNavController());
    Get.put(CartController());
    Get.put(ProfileController());
    Get.put(ReviewController());
    Get.put(ProductCartButtonController());
  }
}
