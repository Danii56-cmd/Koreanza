import 'package:flutter/material.dart';
import 'package:koreanza/models/cart_model.dart';
import 'package:koreanza/models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  void placeOrder({
    required List<CartItemModel> cartItems,
    required int subtotal,
    required String fullName,
    required String address,
    required String city,
    required String phone,
    required String paymentMethod,
  }) {
    final order = OrderModel(
      id: DateTime.now().toString(),
      items: cartItems,
      subtotal: subtotal,
      total: subtotal + 50,
      createdAt: DateTime.now(),
      status: "Processing",

      fullName: fullName,
      address: address,
      city: city,
      phone: phone,
      paymentMethod: paymentMethod,
    );

    _orders.add(order);
    notifyListeners();
  }
}
