// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failure_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FailureModel _$FailureModelFromJson(Map<String, dynamic> json) => FailureModel(
  errors: (json['error'] as List<dynamic>).map((e) => e as String).toList(),
  statusCode: (json['statusCode'] as num).toInt(),
);

Map<String, dynamic> _$FailureModelToJson(FailureModel instance) =>
    <String, dynamic>{
      'error': instance.errors,
      'statusCode': instance.statusCode,
    };
