import 'package:koreanza/models/cart_model.dart';

class OrderModel {
  final String id;
  final List<CartItemModel> items;
  final int subtotal;
  final int total;
  final DateTime createdAt;
  final String status;

  final String fullName;
  final String address;
  final String city;
  final String phone;
  final String paymentMethod;

  OrderModel({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.total,
    required this.createdAt,
    required this.status,
    required this.fullName,
    required this.address,
    required this.city,
    required this.phone,
    required this.paymentMethod,
  });
}
