//TODO don't forget to generate code automatically
import 'package:animooo/models/auth/auth_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_otp_code_response.g.dart';
//{
//     "statusCode": 201,
//     "message": "We send verfication code to your email",
//     "alert": "We send verfication code to your email",
//     "user": {
//         "id": 10,
//         "email": "ahmed122727727@gmail.com",
//         "is_verified": "false"
//     }
// }
@JsonSerializable()
class NewOtpCodeResponse {
  @JsonKey(name: 'statusCode')
  final int statusCode;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'alert')
  final String alert;
  @JsonKey(name: 'user')
  final UserResponseModel user;

  NewOtpCodeResponse({
    required this.statusCode,
    required this.message,
    required this.alert,
    required this.user,
  });

  factory NewOtpCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$NewOtpCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewOtpCodeResponseToJson(this);
}