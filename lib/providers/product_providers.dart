import 'package:flutter/material.dart';
import 'package:koreanza/models/products_model.dart';
import '../core/app_constants.dart';

class ProductProvider extends ChangeNotifier {
  final List<ProductModel> _products = [
    ProductModel(
      id: "1",
      name: "Glow Serum Luxe",
      subtitle: "Ultra Hydrating",
      price: 999,
      rating: 4.8,
      image: AppConstants.wishlistIcon1,
    ),

    ProductModel(
      id: "2",
      name: "Velvet Mist",
      subtitle: "Sensitive Skin",
      price: 999,
      rating: 4.5,
      image: AppConstants.wishlistIcon2,
    ),

    ProductModel(
      id: "3",
      name: "Rose Elixir",
      subtitle: "Anti-Aging",
      price: 999,
      rating: 4.9,
      image: AppConstants.wishlistIcon3,
    ),

    ProductModel(
      id: "4",
      name: "Hydra Boost",
      subtitle: "Deep Moisture",
      price: 999,
      rating: 4.3,
      image: AppConstants.wishlistIcon4,
    ),
  ];

  List<ProductModel> get products => _products;

  // Toggle Favorite
  void toggleFavorite(String productId) {
    final product = _products.firstWhere((e) => e.id == productId);

    product.isFavorite = !product.isFavorite;

    notifyListeners();
  }
}
