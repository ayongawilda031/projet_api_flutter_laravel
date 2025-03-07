import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D6EFD), // Fond bleu (#0D6EFD)
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icône NIKE
            Image.asset(
              'assets/images/logo.png', // Chemin de l'image
              width: 157, // Largeur de l'icône
              height: 54, // Hauteur de l'icône
              color: Colors.white, // Couleur blanche pour l'icône
            ),
            SizedBox(height: 8), // Espace entre l'icône et le texte
            // Texte "NIKE"
            Text(
              'NIKE',
              style: TextStyle(
                color: Colors.white, // Texte blanc
                fontSize: 65, // Taille de la police
                fontWeight: FontWeight.bold, // Texte en gras
              ),
            ),
          ],
        ),
      ),
    );
  }
}