import 'package:flutter/material.dart';
import 'views/login_page.dart'; // Importer la page de connexion
import 'views/home_page.dart'; // Importer la page d'accueil

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nike App',
      debugShowCheckedModeBanner: false, // Désactiver la bannière de débogage
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // Afficher la page de connexion au démarrage
      routes: {
        '/home': (context) => HomePage(), // Route pour la page d'accueil
      },
    );
  }
}