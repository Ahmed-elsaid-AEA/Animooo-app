// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_code_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpCodeResponse _$OtpCodeResponseFromJson(Map<String, dynamic> json) =>
    OtpCodeResponse(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      message: json['message'] as String?,
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      user: json['user'] == null
          ? null
          : UserResponseModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OtpCodeResponseToJson(OtpCodeResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'user': instance.user,
    };
