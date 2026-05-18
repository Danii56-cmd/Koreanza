import 'package:koreanza/models/products_model.dart';

class CartItemModel {
  final ProductModel product;
  final int qty;

  CartItemModel({required this.product, this.qty = 1});

  CartItemModel copyWith({int? qty}) {
    return CartItemModel(product: product, qty: qty ?? this.qty);
  }
}
