// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimalResponseModel _$AnimalResponseModelFromJson(Map<String, dynamic> json) =>
    AnimalResponseModel(
      statusCode: (json['statusCode'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map(
            (e) => AnimalInfoResponseModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$AnimalResponseModelToJson(
  AnimalResponseModel instance,
) => <String, dynamic>{
  'statusCode': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};

AnimalInfoResponseModel _$AnimalInfoResponseModelFromJson(
  Map<String, dynamic> json,
) => AnimalInfoResponseModel(
  animalId: (json['animalId'] as num).toInt(),
  animalName: json['animalName'] as String,
  animalDescription: json['animalDescription'] as String,
  animalImage: json['animalImage'] as String,
  animalPrice: (json['animalPrice'] as num).toDouble(),
  categoryId: (json['categoryId'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  animalCreatedAt: DateTime.parse(json['animalCreatedAt'] as String),
  animalUpdatedAt: DateTime.parse(json['animalUpdatedAt'] as String),
);

Map<String, dynamic> _$AnimalInfoResponseModelToJson(
  AnimalInfoResponseModel instance,
) => <String, dynamic>{
  'animalId': instance.animalId,
  'animalName': instance.animalName,
  'animalDescription': instance.animalDescription,
  'animalImage': instance.animalImage,
  'animalPrice': instance.animalPrice,
  'categoryId': instance.categoryId,
  'userId': instance.userId,
  'animalCreatedAt': instance.animalCreatedAt.toIso8601String(),
  'animalUpdatedAt': instance.animalUpdatedAt.toIso8601String(),
};
