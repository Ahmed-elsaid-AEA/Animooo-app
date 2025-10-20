// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesModelResponse _$CategoriesModelResponseFromJson(
  Map<String, dynamic> json,
) => CategoriesModelResponse(
  statusCode: (json['statusCode'] as num).toInt(),
  categories: (json['Categories'] as List<dynamic>)
      .map((e) => CategoryInfoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CategoriesModelResponseToJson(
  CategoriesModelResponse instance,
) => <String, dynamic>{
  'statusCode': instance.statusCode,
  'Categories': instance.categories,
};
