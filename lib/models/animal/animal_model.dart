import 'dart:io';

class AnimalModel {
  final int categoryId;
  final String name;
  final String description;
  final double price;
  final File image;

  const AnimalModel({
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });
  @override
  String toString() {
    return 'AnimalModel(categoryId: $categoryId, name: $name, description: $description, price: $price, image: $image)';
  }
}
