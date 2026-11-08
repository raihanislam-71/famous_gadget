import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/cart_item.dart';
import '../models/product.dart';
import '../services/cart_storage_service.dart';

class CartController extends GetxController {
  CartController({CartStorageService? storage})
    : _storage = storage ?? CartStorageService();

  final CartStorageService _storage;
  List<CartItem> items = [];
  bool isLoading = true;
  String? errorMessage;
  Future<void>? _loadOperation;
  Future<void> _mutationTail = Future<void>.value();

  int get totalItemCount =>
      items.fold(0, (total, item) => total + item.quantity);

  double get subtotal =>
      items.fold(0, (total, item) => total + item.totalPrice);

  @override
  void onInit() {
    super.onInit();
    _loadOperation = loadCart();
  }

  Future<void> loadCart() async {
    final operation = _loadCart();
    _loadOperation = operation;
    await operation;
  }

  Future<void> _loadCart() async {
    isLoading = true;
    errorMessage = null;
    update();

    try {
      items = await _storage.loadCart();
    } on FormatException catch (error) {
      errorMessage = 'Saved cart data is invalid: ${error.message}';
    } on PlatformException catch (error) {
      errorMessage = 'Could not load your saved cart: ${error.message}';
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> addProduct(
    Product product, {
    required int quantity,
    required String imagePath,
  }) async {
    await (_loadOperation ??= loadCart());
    await _runExclusive(() async {
      if (errorMessage != null) {
        _showError(errorMessage!);
        return;
      }

      final updatedItems = [...items];
      final existingIndex = updatedItems.indexWhere(
        (item) => item.id == product.id,
      );
      if (existingIndex == -1) {
        updatedItems.add(
          CartItem(
            id: product.id,
            name: product.name,
            unitPrice: product.price,
            quantity: quantity,
            imagePath: imagePath,
          ),
        );
      } else {
        final item = updatedItems[existingIndex];
        updatedItems[existingIndex] = item.copyWith(
          quantity: item.quantity + quantity,
        );
      }

      final saved = await _saveItems(updatedItems);
      if (saved) {
        Get.showSnackbar(
          GetSnackBar(
            message: '${product.name} added to cart.',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
            margin: const EdgeInsets.all(10),
            borderRadius: 8,
          ),
        );
      }
    });
  }

  Future<void> updateQuantity(String itemId, int change) async {
    await (_loadOperation ??= loadCart());
    await _runExclusive(() async {
      final itemIndex = items.indexWhere((item) => item.id == itemId);
      if (itemIndex == -1) return;

      final updatedItems = [...items];
      final item = updatedItems[itemIndex];
      final quantity = item.quantity + change;
      if (quantity < 1) {
        updatedItems.removeAt(itemIndex);
      } else {
        updatedItems[itemIndex] = item.copyWith(quantity: quantity);
      }
      await _saveItems(updatedItems);
    });
  }

  Future<void> removeProduct(String itemId) async {
    await (_loadOperation ??= loadCart());
    await _runExclusive(() async {
      final updatedItems = items.where((item) => item.id != itemId).toList();
      await _saveItems(updatedItems);
    });
  }

  Future<void> _runExclusive(Future<void> Function() operation) async {
    final previous = _mutationTail;
    final release = Completer<void>();
    _mutationTail = release.future;
    await previous;
    try {
      await operation();
    } finally {
      release.complete();
    }
  }

  Future<bool> _saveItems(List<CartItem> updatedItems) async {
    try {
      await _storage.saveCart(updatedItems);
      items = updatedItems;
      update();
      return true;
    } on PlatformException catch (error) {
      _showError('Could not save your cart: ${error.message}');
    } on StateError catch (error) {
      _showError(error.message.toString());
    }
    update();
    return false;
  }

  void _showError(String message) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      ),
    );
  }
}
