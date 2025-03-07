class User {
  final int id;
  final String name;
  final String email;
  final String token; // Jeton d'authentification

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  // Convertir un JSON en objet User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      token: json['token'], // Jeton d'authentification
    );
  }
}