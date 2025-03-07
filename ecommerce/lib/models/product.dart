class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final int categoryId;
  final String image;
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.image,
    required this.quantity,
  });

  // Convertir un JSON en objet Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      categoryId: json['category_id'],
      image: json['image'],
      quantity: json['quantity'],
    );
  }
}