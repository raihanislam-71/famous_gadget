import 'package:bdcalling_class/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  void addToCart() {
    Get.showSnackbar(
      GetSnackBar(
        message:
            'Added $quantity item(s) to cart. Total: ৳ ${totalPrice.toStringAsFixed(0)}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      ),
    );
  }
}
