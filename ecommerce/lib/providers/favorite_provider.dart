import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  final List<int> _favoriteProductIds = []; // Liste des IDs des produits favoris

  // Vérifier si un produit est favori
  bool isFavorite(int productId) {
    return _favoriteProductIds.contains(productId);
  }

  // Ajouter ou supprimer un produit des favoris
  void toggleFavorite(int productId) {
    if (_favoriteProductIds.contains(productId)) {
      _favoriteProductIds.remove(productId);
    } else {
      _favoriteProductIds.add(productId);
    }
    notifyListeners(); // Notifier les écouteurs du changement
  }
}