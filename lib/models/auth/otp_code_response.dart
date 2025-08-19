//TODO don't forget to generate code automatically
import 'package:animooo/models/auth/auth_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp_code_response.g.dart';

//{
//     "statusCode": 200,
//     "message": "Verfication successful",
//     "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJhaG1lZDEyMjcyNzcyN0BnbWFpbC5jb20iLCJpYXQiOjE3NDk1NDA2MjAsImV4cCI6MTc0OTYyNzAyMCwiaXNzIjoiYW5pbW9vb19hcGkifQ.6G-voLaJAdlfgaFCaWIBcbpCibBA4_kT7InEK3LwxxQ",
//     "refresh_token": "e6acf9c2-dcf7-4d6b-8ca0-d8de84faa948",
//     "user": {
//         "id": 1,
//         "first_name": "ahmed",
//         "last_name": "elsaid",
//         "email": "ahmed122727727@gmail.com",
//         "phone": "201001398831",
//         "image_path": "http://localhost:8000/api/uploads/1749539458120.png",
//         "is_verified": "true"
//     }
// }

@JsonSerializable()
class OtpCodeResponse {
  int? statusCode;
  String? message;

  @JsonKey(name: 'access_token')
  String? accessToken;
  @JsonKey(name: 'refresh_token')
  String? refreshToken;
  UserResponseModel? user;

  OtpCodeResponse({
    this.statusCode,
    this.message,
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory OtpCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OtpCodeResponseToJson(this);

  @override
  String toString() {
    return 'OtpCodeResponse{statusCode: $statusCode, message: $message, accessToken: $accessToken, refreshToken: $refreshToken, user: $user}';
  }
}
