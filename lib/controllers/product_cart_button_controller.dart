import 'package:bdcalling_class/models/product.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';
import 'cart_controller.dart';

class ProductCartButtonController extends GetxController {
  int quantity = 1;

  void updateQuantity(int value) {
    if (quantity + value >= 1) {
      quantity += value;
      update();
    }
  }

  void addToCart(Product product) {
    Get.find<AuthController>().requireAuthentication(
      onAuthenticated: () {
        Get.find<CartController>().addProduct(
          product,
          quantity: quantity,
          imagePath: product.imagePath,
        );
      },
    );
  }
}
