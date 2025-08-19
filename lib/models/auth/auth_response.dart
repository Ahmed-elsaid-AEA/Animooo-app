//TODO don't forget to generate code automatically
import 'package:json_annotation/json_annotation.dart';

//{
//     "statusCode": 201,
//     "message": "Signup successful!",
//     "alert": "We send verfication code to your email",
//     "user": {
//         "id": 1,
//         "first_name": "ahmed",
//         "last_name": "elsaid",
//         "email": "ahmed122727727@gmail.com",
//         "phone": "201001398831",
//         "image_path": "http://localhost:8000/api/uploads/1749539458120.png",
//         "is_verified": "false"
//     }

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  int? statusCode;
  String? message;
  String? alert;
  UserResponseModel? user;

  AuthResponse({this.statusCode, this.message, this.alert, this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

  @override
  String toString() {
    return 'AuthResponse{statusCode: $statusCode, message: $message, alert: $alert, user: $user}';
  }
}

@JsonSerializable()
class UserResponseModel {
  int? id;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'last_name')
  String? lastName;
  String? email;
  String? phone;
  @JsonKey(name: 'image_path')
  String? imagePath;
  @JsonKey(name: 'is_verified')
  String? isVerified;

  UserResponseModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.imagePath,
    this.isVerified,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);

  @override
  String toString() {
    return 'UserResponseModel{id: $id, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, imagePath: $imagePath, isVerified: $isVerified}';
  }
}
