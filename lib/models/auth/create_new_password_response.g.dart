// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_new_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateNewPasswordResponse _$CreateNewPasswordResponseFromJson(
  Map<String, dynamic> json,
) => CreateNewPasswordResponse(
  statusCode: (json['statusCode'] as num).toInt(),
  message: json['message'] as String,
  accessToken: json['access_token'] as String,
  refreshToken: json['refresh_token'] as String,
  user: UserResponseModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreateNewPasswordResponseToJson(
  CreateNewPasswordResponse instance,
) => <String, dynamic>{
  'statusCode': instance.statusCode,
  'message': instance.message,
  'access_token': instance.accessToken,
  'refresh_token': instance.refreshToken,
  'user': instance.user,
};
