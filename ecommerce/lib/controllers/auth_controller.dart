import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../constants/constants.dart'; // Importer les constantes

class AuthController {
  // Méthode pour se connecter
  static Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiConstants.loginEndpoint), // Utiliser la constante
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Si la connexion réussit, retourner un objet User
      return User.fromJson(jsonDecode(response.body));
    } else {
      // Si la connexion échoue, lancer une exception
      throw Exception('Échec de la connexion : ${response.body}');
    }
  }

  // Méthode pour s'inscrire
  static Future<User> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiConstants.registerEndpoint), // Utiliser la constante
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
      }),
    );

    if (response.statusCode == 200) {
      // Si l'inscription réussit, retourner un objet User
      return User.fromJson(jsonDecode(response.body));
    } else {
      // Si l'inscription échoue, lancer une exception
      throw Exception('Échec de l\'inscription : ${response.body}');
    }
  }
}