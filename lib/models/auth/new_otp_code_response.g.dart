// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_otp_code_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewOtpCodeResponse _$NewOtpCodeResponseFromJson(Map<String, dynamic> json) =>
    NewOtpCodeResponse(
      statusCode: (json['statusCode'] as num).toInt(),
      message: json['message'] as String,
      alert: json['alert'] as String,
      user: UserResponseModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewOtpCodeResponseToJson(NewOtpCodeResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'alert': instance.alert,
      'user': instance.user,
    };
