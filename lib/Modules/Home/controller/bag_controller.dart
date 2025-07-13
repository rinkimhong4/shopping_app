import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/Modules/Home/models/product_model_fake_api.dart';
import 'package:shopping_app/configs/Theme/app_theme.dart';

class BagController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final Rx<Color> appBarColor = AppColors.accent.obs;
  final cartItems = <Map<String, dynamic>>[].obs;
  static const String _cartKey = 'cart_items';

  @override
  void onInit() {
    super.onInit();
    _loadCartItems();
    scrollController.addListener(() {
      if (scrollController.offset > 40) {
        appBarColor.value = AppColors.accent;
      } else {
        appBarColor.value = AppColors.accent;
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  // Load cart items from shared_preferences
  Future<void> _loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString(_cartKey);
    if (cartData != null) {
      try {
        final List<dynamic> jsonData = jsonDecode(cartData);
        cartItems.assignAll(
          jsonData.cast<Map<String, dynamic>>().map((item) {
            return {
              'id': item['id'].toString(),
              'title': item['title']?.toString() ?? '',
              'price': double.tryParse(item['price'].toString()) ?? 0.0,
              'discount': double.tryParse(item['discount'].toString()) ?? 0.0,
              'image': item['image']?.toString() ?? '',
              'quantity': (item['quantity'] as num?)?.toInt() ?? 1,
              'size': item['size']?.toString(),
              'color': item['color']?.toString(),
              'priceRange': item['priceRange'],
            };
          }).toList(),
        );
        cartItems.refresh();
      } catch (e) {
        // print('Error loading cart items: $e');
      }
    }
  }

  // Save cart items to shared_preferences
  Future<void> _saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(_cartKey, jsonEncode(cartItems));
    } catch (e) {
      // print('Error saving cart items: $e');
    }
  }

  void addToCart(
    dynamic product,
    int quantity, {
    String? size,
    Color? color,
    RangeValues? priceRange,
  }) {
    final String productId =
        product is Product ? product.id.toString() : product.id.toString();
    final String productTitle =
        product is Product ? (product.title ?? '') : (product.title ?? '');
    final double productPrice =
        product is Product
            ? (double.tryParse(product.price ?? '0.0') ?? 0.0)
            : (product.price as num?)?.toDouble() ?? 0.0;
    final double productDiscount =
        product is Product
            ? (double.tryParse(product.discount ?? '0.0') ?? 0.0)
            : (productPrice * 0.45); // 45% discount for TShirtModel
    final String productImage =
        product is Product ? (product.image ?? '') : (product.image ?? '');

    final existingItemIndex = cartItems.indexWhere(
      (item) =>
          item['id'] == productId &&
          item['size'] == size &&
          item['color'] == color?.toString(),
    );
    if (existingItemIndex != -1) {
      cartItems[existingItemIndex]['quantity'] =
          cartItems[existingItemIndex]['quantity'] + quantity;
    } else {
      cartItems.add({
        'id': productId,
        'title': productTitle,
        'price': productPrice,
        'discount': productDiscount,
        'image': productImage,
        'quantity': quantity,
        'size': size,
        'color': color?.toString(),
        'priceRange':
            priceRange != null
                ? {'start': priceRange.start, 'end': priceRange.end}
                : null,
      });
    }
    cartItems.refresh();
    _saveCartItems();
  }

  void updateQuantity(
    String productId,
    int newQuantity, {
    String? size,
    String? color,
  }) {
    final existingItemIndex = cartItems.indexWhere(
      (item) =>
          item['id'] == productId &&
          item['size'] == size &&
          item['color'] == color,
    );
    if (existingItemIndex != -1) {
      cartItems[existingItemIndex]['quantity'] = newQuantity;
      cartItems.refresh();
      _saveCartItems();
    }
  }

  void removeFromCart(String productId, {String? size, String? color}) {
    cartItems.removeWhere(
      (item) =>
          item['id'] == productId &&
          item['size'] == size &&
          item['color'] == color,
    );
    cartItems.refresh();
    _saveCartItems();
  }

  double getTotalAmount() {
    return cartItems.fold(0.0, (sum, item) {
      final price =
          (double.tryParse(item['price'].toString()) ?? 0.0) -
          (double.tryParse(item['discount'].toString()) ?? 0.0);
      final quantity = (item['quantity'] as num?)?.toInt() ?? 1;
      return sum + (price * quantity);
    });
  }
}
