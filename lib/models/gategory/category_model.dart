import 'dart:io';

class CategoryModel {
  final String name;
  final String description;
  final File image;

  const CategoryModel({
    required this.name,
    required this.description,
    required this.image,
  });
  @override
  String toString() {
    return 'CategoryModel(name: $name, description: $description, image: $image)';
  }
}
