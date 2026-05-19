import 'package:flutter/material.dart';
import 'package:koreanza/models/cart_model.dart';
import 'package:koreanza/models/products_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => _items;

  // ADD TO CART
  void addToCart(ProductModel product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      final existing = _items[index];
      _items[index] = existing.copyWith(qty: existing.qty + 1);
    } else {
      _items.add(CartItemModel(product: product));
    }

    notifyListeners();
  }

  // REMOVE ITEM
  void removeItem(String productId) {
    _items.removeWhere((e) => e.product.id == productId);
    notifyListeners();
  }

  // INCREASE
  void increaseQty(String productId) {
    final index = _items.indexWhere((e) => e.product.id == productId);
    if (index != -1) {
      final item = _items[index];
      _items[index] = item.copyWith(qty: item.qty + 1);
      notifyListeners();
    }
  }

  // DECREASE
  void decreaseQty(String productId) {
    final index = _items.indexWhere((e) => e.product.id == productId);

    if (index == -1) return;

    final item = _items[index];

    if (item.qty > 1) {
      _items[index] = item.copyWith(qty: item.qty - 1);
    } else {
      _items.removeAt(index);
    }

    notifyListeners();
  }

  // TOTAL ITEMS
  int get totalItems => _items.fold(0, (sum, e) => sum + e.qty);

  // TOTAL PRICE
  int get totalPrice {
    return _items.fold(0, (sum, e) {
      return sum + (e.product.price * e.qty);
    });
  }

  bool isInCart(String productId) {
    return _items.any((e) => e.product.id == productId);
  }

  // CLEAR ALL ITEMS (call after order is placed)
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
