// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      statusCode: (json['statusCode'] as num).toInt(),
      category: CategoryInfoModel.fromJson(
        json['Category'] as Map<String, dynamic>,
      ),
      message: json['message'] as String,
    );

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'Category': instance.category,
      'message': instance.message,
    };

CategoryInfoModel _$CategoryInfoModelFromJson(Map<String, dynamic> json) =>
    CategoryInfoModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      imagePath: json['imagePath'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$CategoryInfoModelToJson(CategoryInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imagePath': instance.imagePath,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'userId': instance.userId,
    };
