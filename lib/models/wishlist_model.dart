// Wishlist model

import 'dart:ui';

class WishlistProduct {
  final String name;
  final String subtitle;
  final String price;
  final double rating;
  final String image;
  final String? badge;
  final Color? badgeColor;

  const WishlistProduct({
    required this.name,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.image,
    this.badge,
    this.badgeColor,
  });
}
