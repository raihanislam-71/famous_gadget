import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_item.dart';

class CartStorageService {
  static const _storageKey = 'shopping_cart_v1';

  Future<List<CartItem>> loadCart() async {
    final preferences = await SharedPreferences.getInstance();
    final encodedItems = preferences.getString(_storageKey);
    if (encodedItems == null || encodedItems.isEmpty) return [];

    final decodedItems = jsonDecode(encodedItems);
    if (decodedItems is! List) {
      throw const FormatException('Saved cart must be a list.');
    }
    return decodedItems.map(CartItem.fromJson).toList();
  }

  Future<void> saveCart(List<CartItem> items) async {
    final preferences = await SharedPreferences.getInstance();
    final saved = await preferences.setString(
      _storageKey,
      jsonEncode(items.map((item) => item.toJson()).toList()),
    );
    if (!saved) throw StateError('The cart could not be saved locally.');
  }
}
