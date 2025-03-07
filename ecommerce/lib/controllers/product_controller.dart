// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../constants/constants.dart'; // Importer les constantes
import 'package:shared_preferences/shared_preferences.dart';

class ProductController {

  Future<String?> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh_token');
    if (refreshToken == null) {
      throw Exception('Refresh token non trouvé');
    }

    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/refresh-token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh_token': refreshToken}),
    );

    if (response.statusCode == 200) {
      final newToken = jsonDecode(response.body)['token'];
      await prefs.setString('token', newToken);
      return newToken;
    } else {
      throw Exception('Échec du rafraîchissement du token');
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(
      'token',
    ); // Remplacez 'user_token' par la clé utilisée pour stocker le token
  }

  // Méthode pour récupérer les produits
  Future<List<Product>> getProducts() async {
    try {
      print('Tentative de récupération des produits depuis l\'API...');

      // Récupérer le token
      String? token = await getToken();
      if (token == null) {
        throw Exception('Token d\'authentification non trouvé');
      }

      var response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/products'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      // Si le token est expiré, rafraîchir le token et réessayer
      if (response.statusCode == 401) {
        print('Token expiré. Tentative de rafraîchissement du token...');
        token = await refreshToken();
        if (token == null) {
          throw Exception('Échec du rafraîchissement du token');
        }

        response = await http.get(
          Uri.parse('${ApiConstants.baseUrl}/products'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
      }

      print('Statut de la réponse : ${response.statusCode}');
      print('Corps de la réponse : ${response.body}');

      if (response.statusCode == 200) {
        print('Réponse réussie. Conversion du JSON en liste de produits...');
        final List<dynamic> data = jsonDecode(response.body);
        print('Données JSON décodées : $data');

        final products = data.map((json) => Product.fromJson(json)).toList();
        print(
          'Produits chargés avec succès : ${products.length} produits trouvés',
        );
        return products;
      } else {
        print(
          'Échec du chargement des produits. Statut de la réponse : ${response.statusCode}',
        );
        throw Exception('Échec du chargement des produits');
      }
    } catch (e) {
      print('Erreur lors de la récupération des produits : $e');
      throw Exception('Erreur lors de la récupération des produits : $e');
    }
  }

  // Méthode pour ajouter un produit aux favoris
  static Future<void> addToFavorites(int productId) async {
    try {
      print('Tentative d\'ajout du produit $productId aux favoris...');
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/favorites'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'product_id': productId}),
      );

      // Afficher le statut de la réponse et le corps de la réponse
      print('Statut de la réponse : ${response.statusCode}');
      print('Corps de la réponse : ${response.body}');

      if (response.statusCode != 200) {
        print(
          'Échec de l\'ajout aux favoris. Statut de la réponse : ${response.statusCode}',
        );
        throw Exception('Échec de l\'ajout aux favoris');
      } else {
        print('Produit $productId ajouté aux favoris avec succès');
      }
    } catch (e) {
      print('Erreur lors de l\'ajout aux favoris : $e');
      throw Exception('Erreur lors de l\'ajout aux favoris : $e');
    }
  }

  // Méthode pour ajouter un produit au panier
  static Future<void> addToCart(int productId) async {
    try {
      print('Tentative d\'ajout du produit $productId au panier...');
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/cart'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'product_id': productId}),
      );

      // Afficher le statut de la réponse et le corps de la réponse
      print('Statut de la réponse : ${response.statusCode}');
      print('Corps de la réponse : ${response.body}');

      if (response.statusCode != 200) {
        print(
          'Échec de l\'ajout au panier. Statut de la réponse : ${response.statusCode}',
        );
        throw Exception('Échec de l\'ajout au panier');
      } else {
        print('Produit $productId ajouté au panier avec succès');
      }
    } catch (e) {
      print('Erreur lors de l\'ajout au panier : $e');
      throw Exception('Erreur lors de l\'ajout au panier : $e');
    }
  }
}
