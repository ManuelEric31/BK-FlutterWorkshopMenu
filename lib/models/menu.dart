// lib/models/menu.dart

class Menu {
  final int id;
  final String name;
  final String? description;
  final double price;
  final int restoId;
  final String? image;

  Menu({
    this.id = 0,
    required this.name,
    required this.restoId,
    this.description,
    required this.price,
    this.image,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      name: json['name'],
      restoId: json['restaurant'],
      description: json['description'],
      price: double.parse(json['price']),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.name,
      'name': this.name,
      'restaurant_id': this.restoId,
      'description': this.description,
      'price': this.price,
      'image': this.image,
    };
  }
}
