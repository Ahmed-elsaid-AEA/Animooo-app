import 'package:animooo/models/auth/auth_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_new_password_response.g.dart';

@JsonSerializable()
class CreateNewPasswordResponse {
  final int statusCode;
  final String message;
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  final UserResponseModel user;

  CreateNewPasswordResponse({
    required this.statusCode,
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory CreateNewPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateNewPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateNewPasswordResponseToJson(this);
}