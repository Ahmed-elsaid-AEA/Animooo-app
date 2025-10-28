import 'package:json_annotation/json_annotation.dart';

part 'animal_response_model.g.dart';

@JsonSerializable()
class AnimalResponseModel {
  final int statusCode;
  final String message;
  final List<AnimalInfoResponseModel> animal;

  const AnimalResponseModel({
    required this.statusCode,
    required this.message,
    required this.animal,
  });

  factory AnimalResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AnimalResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnimalResponseModelToJson(this);
}

@JsonSerializable()
class AnimalInfoResponseModel {
  //   "animal_id": 3,
  //         "animal_name": "بيدبول 3",
  //         "animal_description": "هذا حيوان اليف",
  //         "animal_image": "http://localhost:8000/api/uploads/1761666210244.png",
  //         "animal_price": 100.0,
  //         "category_id": 10,
  //         "user_id": 19,
  //         "animal_created_at": "2025-10-28 18:43:30.327104",
  //         "animal_update_at": "2025-10-28 18:43:30.327104"
  final int animalId;
  final String animalName;
  final String animalDescription;
  final String animalImage;
  final double animalPrice;
  final int categoryId;
  final int userId;
  final DateTime animalCreatedAt;
  final DateTime animalUpdatedAt;

  const AnimalInfoResponseModel({
    required this.animalId,
    required this.animalName,
    required this.animalDescription,
    required this.animalImage,
    required this.animalPrice,
    required this.categoryId,
    required this.userId,
    required this.animalCreatedAt,
    required this.animalUpdatedAt,
  });

  factory AnimalInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AnimalInfoResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnimalInfoResponseModelToJson(this);
}
