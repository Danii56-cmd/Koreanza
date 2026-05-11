// Product model
import 'dart:ui';

class Product {
  final String name;
  final String subtitle;
  final String price;
  final double rating;
  final String image;
  final String? badge;
  final Color? badgeColor;

  const Product({
    required this.name,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.image,
    this.badge,
    this.badgeColor,
  });
}


