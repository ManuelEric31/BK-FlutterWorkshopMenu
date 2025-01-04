// lib/models/restaurant.dart
class Restaurant {
  late int id;
  final String name;
  final String? description;
  final String? address;
  final String? phone;
  final String? website;
  final double? latitude;
  final double? longitude;
  final String? image;

  Restaurant(
      {this.id = 0,
      required this.name,
      this.description,
      this.address,
      this.phone,
      this.website,
      this.latitude,
      this.longitude,
      this.image});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      phone: json['phone'],
      website: json['website'],
      latitude: json['lattitude'],
      longitude: json['longitude'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'address': this.address,
      'description': this.description,
      'phone': this.phone,
      'website': this.website,
      'lattitude': this.latitude,
      'longitude': this.longitude,
    };
  }
}
