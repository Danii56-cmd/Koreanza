import 'package:flutter/material.dart';
import 'package:koreanza/models/products_model.dart';

class WishlistProvider extends ChangeNotifier {
  final List<ProductModel> _items = [];

  List<ProductModel> get items => _items;

  void toggleWishlist(ProductModel product) {
    final index = _items.indexWhere((e) => e.id == product.id);

    if (index >= 0) {
      _items.removeAt(index);
    } else {
      _items.add(product);
    }

    notifyListeners();
  }

  bool isWishlisted(String productId) {
    return _items.any((e) => e.id == productId);
  }

  int get count => _items.length;
}
