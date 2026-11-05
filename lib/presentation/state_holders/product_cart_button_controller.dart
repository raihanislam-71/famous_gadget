import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCartButtonController extends GetxController {
  int quantity = 1;
  double unitPrice = 32500.0;

  void updateQuantity(int value) {
    if (quantity + value >= 1) {
      quantity += value;
      update();
    }
  }

  double get totalPrice => unitPrice * quantity;

/*  void addToCart() {
    // এখানে API কল বা লোকাল ডাটাবেস লজিক হবে
    Get.snackbar(
      "Success",
      "Added $quantity item(s) to cart. Total: ৳ $totalPrice",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }*/
  void addToCart() {
    // Get.showSnackbar ব্যবহার করলে শুধু message দেওয়া যায়
    Get.showSnackbar(
      GetSnackBar(
        message: "Added $quantity item(s) to cart. Total: ৳ ${totalPrice.toStringAsFixed(0)}",
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