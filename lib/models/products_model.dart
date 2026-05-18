// Product model
import 'dart:ui';

class ProductModel {
  final String id;
  final String name;
  final String subtitle;
  final int price;
  final double rating;
  final String image;
  final String? badge;
  final Color? badgeColor;
  bool isFavorite;

  ProductModel({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.image,
    this.badge,
    this.badgeColor,
    this.isFavorite = false,
  });
}
