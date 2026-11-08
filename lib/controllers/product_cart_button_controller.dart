import 'package:bdcalling_class/models/product.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';
import 'cart_controller.dart';
import '../view/utils/assets_path.dart';

class ProductCartButtonController extends GetxController {
  int quantity = 1;
  double unitPrice = Product.featured.price;

  void updateQuantity(int value) {
    if (quantity + value >= 1) {
      quantity += value;
      update();
    }
  }

  double get totalPrice => unitPrice * quantity;

  void addToCart(Product product) {
    Get.find<AuthController>().requireAuthentication(
      onAuthenticated: () {
        Get.find<CartController>().addProduct(
          product,
          quantity: quantity,
          imagePath: AssetsPath.productImage,
        );
      },
    );
  }
}
