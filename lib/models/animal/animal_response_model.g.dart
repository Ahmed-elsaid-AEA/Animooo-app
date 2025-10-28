// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalResponseModel _$AnimalResponseModelFromJson(Map<String, dynamic> json) =>
    AnimalResponseModel(
      statusCode: (json['statusCode'] as num).toInt(),
      message: json['message'] as String,
      animal: AnimalInfoResponseModel.fromJson(
        json['animal'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$AnimalResponseModelToJson(
  AnimalResponseModel instance,
) => <String, dynamic>{
  'statusCode': instance.statusCode,
  'message': instance.message,
  'animal': instance.animal,
};

AnimalInfoResponseModel _$AnimalInfoResponseModelFromJson(
  Map<String, dynamic> json,
) => AnimalInfoResponseModel(
  animalId: (json['animal_id'] as num).toInt(),
  animalName: json['animal_name'] as String,
  animalDescription: json['animal_description'] as String,
  animalImage: json['animal_image'] as String,
  animalPrice: (json['animal_price'] as num).toDouble(),
  categoryId: (json['category_id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  animalCreatedAt: DateTime.parse(json['animal_created_at'] as String),
  animalUpdatedAt: DateTime.parse(json['animal_update_at'] as String),
);

Map<String, dynamic> _$AnimalInfoResponseModelToJson(
  AnimalInfoResponseModel instance,
) => <String, dynamic>{
  'animal_id': instance.animalId,
  'animal_name': instance.animalName,
  'animal_description': instance.animalDescription,
  'animal_image': instance.animalImage,
  'animal_price': instance.animalPrice,
  'category_id': instance.categoryId,
  'user_id': instance.userId,
  'animal_created_at': instance.animalCreatedAt.toIso8601String(),
  'animal_update_at': instance.animalUpdatedAt.toIso8601String(),
};
